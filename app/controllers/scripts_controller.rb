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
    
    to_be_created = []
    
    feed.events_in_year(2011).each do |e|
      if stages.include?(e.location)
        event = Event.new
        event.stage_id = stages[e.location]
        event.title = e.summary
        event.event_dates.build(:datetime => e.dtstart)
        to_be_created << event
      end
    end
    
    @debug = to_be_created
    render :cinematik
  end
end
