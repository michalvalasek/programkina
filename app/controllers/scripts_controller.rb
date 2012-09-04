#encoding: utf-8

require 'open-uri'

class ScriptsController < ApplicationController
  
  def index
    sd = current_user.account.subdomain.to_s
    #sd = :cinematik #dev only
    if sd!=nil && self.respond_to?(sd)
      if !params[:subaction].blank? && self.respond_to?("#{sd}_#{params[:subaction]}".to_s)
        self.send("#{sd}_#{params[:subaction]}".to_s)
      else
        self.send(sd)
      end
    else
      render :index
    end
  end
  
  def cinematik
    render :cinematik
  end
  
  def cinematik_feeder
    feed = CinematikCalendar.new
    
    stages = {}
    current_user.stages.each { |s| stages[s.name] = s.id }
    
    events_created = 0
    events_updated = 0
    
    feed.events_in_year(2012).each do |e|
      if stages.include?(e.location)
        
        event = Event.new
        event.stage_id = stages[e.location]
        event.title = e.summary
        
        event.event_dates.build(:datetime => e.dtstart)
          
        existing_event = Event.where(:stage_id => current_user.stages, :title => e.summary).first
        if existing_event.nil?
          # create new event
          desc = e.description.split("\n\n")
          unless desc.empty?
            desc.first.match(/\A([^;]*);(.*)/) do |m|
              event.orig_title = m[1]
              event.info = m[2]
            end
            event.description = "#{desc[1]}<br /><br /><i>#{desc[2]}</i>".html_safe
          end
          
          e.description.match(/http:\/\/www\.youtube\.com\/watch\?v=(\S+)/) do |m|
            event.trailer = m[1]
          end
          
          e.description.match(/(http:\/\/www\.cinematik\.sk\/[\S]*)/) do |m|
            info_from_web = parse_cinematik_page(m[0])
            event.description = info_from_web[:description] unless info_from_web[:description].blank?
            event.trailer = info_from_web[:trailer] if event.trailer.blank? && !info_from_web[:trailer].blank?
            event.poster = info_from_web[:poster] unless info_from_web[:poster].blank?
          end
          event.event_type = "Filmové predstavenie"
          event.projection_type = "2D"
          
          events_created += 1
          
          event.save
        else
          #update the event's stage and times if needed
          updated = false
          unless existing_event.stage_id == event.stage_id
            existing_event.update_attribute(:stage_id, event.stage_id)
            updated = true
          end
          unless existing_event.event_dates.first.datetime == event.event_dates.first.datetime
            existing_event.event_dates.first.update_attribute(:datetime, event.event_dates.first.datetime)
            updated = true
          end
          
          events_updated += 1 if updated
        end
      end
    end
    
    redirect_to scripts_path, notice: "Feeder skript dokončený.<br />Vytvorených podujatí: #{events_created}<br />Updatnutých podujatí: #{events_updated}".html_safe
  end
  
  def cinematik_cleaner
    events_deleted = Event.where(:stage_id => current_user.stages).delete_all
    redirect_to scripts_path, notice: "Cleaner skript dokončený.<br />Vymazaných podujatí: #{events_deleted}".html_safe
  end
  
  private
  
    def parse_cinematik_page(url)
      output = {}
      url.match(/\Ahttp:\/\/www\.cinematik\.sk\/.*\z/) do |m|
        doc = Nokogiri::HTML(open(m[0]))
        nodes = doc.css('.entry > p, .entry > ul')
        output[:description] = nodes.slice(1,nodes.length-1).to_s
        
        # get the youtube code of the trailer
        trailer = doc.css('.entry .video iframe')
        unless trailer.empty?
          output[:trailer] = trailer[0]['src'].split('/').last
        end
      end
      output
    end
    
end
