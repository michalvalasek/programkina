#encoding: utf-8

class Account < ActiveRecord::Base
  belongs_to :user
  
  TYPE_THEATER = :theater
  TYPE_FESTIVAL = :festival
  
  attr_accessible :account_type, :name, :subdomain
  
  validate :account_type, :inclusion => { :in => [TYPE_THEATER, TYPE_FESTIVAL], :message => "hodnota nebola zvolená korektne." }
  validate :name, :subdomain, :presence
  validate :subdomain, :length => { :in => 1..20 }
  validate :subdomain, :format => { :with => /\A[a-z0-9]+\z/, :message => "povolené znaky sú len malé písmená bez diakritiky a číslice." }
  validate :subdomain, :uniqueness => true
  
  def account_type=(value)
    write_attribute(:account_type, value.to_s)
  end
  
  def account_type
    type = read_attribute(:account_type)
    type.to_sym unless type.nil?
  end
  
  def theater?
    self.account_type == TYPE_THEATER
  end
  
  def festival?
    self.account_type == TYPE_FESTIVAL
  end
  
  def festival_days
    user_stages = self.user.stages
    EventDate.where('stage_id IN (?)', user_stages).group(:date)
  end
end
