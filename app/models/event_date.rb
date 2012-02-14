class EventDate < ActiveRecord::Base

  belongs_to :event

  attr_accessible :date, :datetime

  validates :date, :datetime, presence: true

end
