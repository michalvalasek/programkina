class Stage < ActiveRecord::Base
  
  belongs_to :user
  has_many :events, dependent: :destroy

end
