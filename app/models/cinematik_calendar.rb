require 'open-uri'

class CinematikCalendar
  
  GOOGLE_ICS = "https://www.google.com/calendar/ical/10m2lcml6frt9di5vkg5avu460%40group.calendar.google.com/public/basic.ics"
  LOCAL_TIMEZONE = "Bratislava"
  
  attr_accessor :cal
  
  def initialize(ics = GOOGLE_ICS)
    self.cal = Icalendar::parse(open(ics).read).first
  #rescue *HTTP_ERRORS => error 
  end
  
  def all_events
    cal.events
  end
  
  def events_in_year(year = 2011)
    cal.events.select { |event| event.dtstart.year == year }
              .sort_by { |event| event.dtstart }
  end
end