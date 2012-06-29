#encoding: utf-8

class User < ActiveRecord::Base
  ACCOUNT_TYPE_THEATER = :theater
  ACCOUNT_TYPE_FESTIVAL = :festival
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :account_type

  has_many :stages
  
  validates :account_type, :inclusion => { :in => [ACCOUNT_TYPE_THEATER, ACCOUNT_TYPE_FESTIVAL], :message => "hodnota nebola zvolená korektne." }

  after_create do |user|
    user.stages.create(:name=>"Hlavné javisko")
  end
  
  def account_type=(value)
    write_attribute(:account_type, value.to_s)
  end
  
  def account_type
    read_attribute(:account_type).to_sym
  end
end
