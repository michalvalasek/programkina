#encoding: utf-8

class Account < ActiveRecord::Base
  belongs_to :user
  
  TYPE_THEATER = :theater
  TYPE_FESTIVAL = :festival
  
  attr_accessible :account_type, :name
  
  validate :account_type, :inclusion => { :in => [TYPE_THEATER, TYPE_FESTIVAL], :message => "hodnota nebola zvolená korektne." }
  validate :name, :presence
  
  def account_type=(value)
    write_attribute(:account_type, value.to_s)
  end
  
  def account_type
    type = read_attribute(:account_type)
    type.to_sym unless type.nil?
  end
end
