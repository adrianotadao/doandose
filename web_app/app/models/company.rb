class Company
  include Mongoid::Document

  #relationship
  embeds_one :address
  embeds_one :contact
  embeds_many :users
  
  accepts_nested_attributes_for :address, :contact, :users, :allow_destoy => true
end