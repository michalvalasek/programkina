class Event < ActiveRecord::Base

  has_many :event_dates, dependent: :destroy

  attr_accessible :title, :title_orig, :description, :event_type, :info, :poster, :trailer

  validates :title, :description, :event_type, :info, presence: true
  validates :title, :title_orig, :poster, :trailer, length: { maximum: 250 }
  validates :event_type, length: { maximum: 100 }

end