class EventDate < ActiveRecord::Base

  belongs_to :event

  attr_accessible :date, :datetime

  validates :datetime, presence: true

  before_save { |record| record.date = record.datetime.strftime("%Y%m%d") }

end
