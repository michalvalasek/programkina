class EventDate < ActiveRecord::Base

  belongs_to :event

  attr_accessible :date, :datetime, :stage_id

  validates :datetime, presence: true

  before_save do |record|
    record.date = record.datetime.strftime("%Y%m%d")
    record.stage_id = record.event.stage.id
  end
  
  def events_on_date
    EventDate.where(:date => self.date, :stage_id => self.stage_id).group(:event_id).collect do |ed|
      ed.event
    end
  end

end
