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
    
    events_created = []
    events_updated = []
    
    #feed.events_in_year(2011)[0..3].each do |e| # TESTING
    feed.events_in_year(2011).each do |e| # REAL THING
      if stages.include?(e.location)
        event = Event.new
        event.stage_id = stages[e.location]
        event.title = e.summary
        
        event.event_dates.build(:datetime => e.dtstart)
        
        existing_event = Event.find_by_title(event.title)
        if existing_event.nil?
          # create new event
          
          desc = e.description.split("\n\n")
          desc.first.match(/\A([^;]*);(.*)/) do |m|
            event.orig_title = m[1]
            event.info = m[2]
          end
          
          info_from_web = parse_cinematik_page(desc.last)
          unless info_from_web.empty?
            event.description = info_from_web[:description]
            event.trailer = info_from_web[:trailer]
            event.poster = info_from_web[:poster]
          end
          
          event.event_type = "Filmové predstavenie"
          event.projection_type = "2D"
          
          events_created << event
          
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
          
          events_updated << existing_event.title if updated
        end
      end
    end
    
    redirect_to scripts_path, notice: "Vytvorených #{events_created.size}, updatnutých: #{events_updated.size}"
  end
  
  private
  
    def parse_cinematik_page(url)
      output = {
        :description => "",
        :trailer => "",
        :poster => nil
      }
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
