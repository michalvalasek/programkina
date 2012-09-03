#encoding: utf-8

class User < ActiveRecord::Base
  has_many :stages
  has_one :account
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :account_attributes
  
  accepts_nested_attributes_for :account
  
  after_create do |user|
    user.stages.create(:name=>"Hlavná sála")
  end 
end
