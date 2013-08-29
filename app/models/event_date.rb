class EventDate < ActiveRecord::Base

  belongs_to :event

  attr_accessible :date, :datetime, :stage_id

  validates :datetime, presence: true

  before_save do |record|
    event_day = record.datetime
    event_day -= 1.day if event_day.hour < 4 # adjust date for night events (starting between midnight and 4AM)
    record.date = event_day.strftime("%Y%m%d")
    record.stage_id = record.event.stage.id
  end
  
  def events_on_date_and_stage
    EventDate.where(:date => self.date, :stage_id => self.stage_id).group(:event_id).collect do |ed|
      ed.event
    end
  end

  def events_on_date_and_section(section)
    EventDate.where("date=:date AND event_id IN (:events)", {date: self.date, events: section.events})
      .group(:event_id)
      .collect{|ed| ed.event }
  end
  
  def events_on_datetime(stage_id = nil)
    conds = {:datetime => self.datetime}
    conds[:stage_id] = stage_id unless stage_id.nil?
    
    EventDate.where(conds).group(:event_id).collect { |ed|
      ed.event
    }.compact
  end
end
