#encoding: utf-8

class Event < ActiveRecord::Base

  belongs_to :stage
  belongs_to :section
  has_many :event_dates, dependent: :delete_all
 
  attr_accessible :title, :orig_title, :description, :event_type, :projection_type, :info, :poster, :trailer, :event_dates_attributes, :section_id
  accepts_nested_attributes_for :event_dates, allow_destroy: true
  
  EVENT_TYPES = ["Filmové predstavenie", "Filmový klub", "Detské predstavenie"]
  PROJECTION_TYPES = ["2D", "3D", "35mm"]

  validates :title, :description, :event_type, :projection_type, presence: true
  validates :title, :orig_title, :poster, :trailer, length: { maximum: 250 }
  validates :event_type, length: { maximum: 100 }
  validates :event_type, inclusion: { in: EVENT_TYPES, message: "%{value} nie je valídny typ podujatia" } 
  validates :projection_type, inclusion: { in: PROJECTION_TYPES, message: "%{value} nie je valídny typ premietania" }
  validates :section_id, inclusion: { in: Section.all.map(&:id), message: "Neexistujúca %{value}" }, allow_blank: true
end