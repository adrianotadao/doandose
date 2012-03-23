class Company
  include Mongoid::Document
  include Mongoid::Timestamps

  #relationship
  has_one :address
  has_one :contact
  has_many :users
  
  accepts_nested_attributes_for :address, :contact, :users, :allow_destoy => true
end