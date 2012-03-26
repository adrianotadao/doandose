class Company
  include Mongoid::Document
  include Mongoid::Timestamps

  field :active, :type => Boolean
  field :name, :type => String
  field :fancy_name, :type => String
  field :cnpj, :type => String
  field :responsible, :type => String

  #relationship
  has_one :address
  has_one :contact
  has_many :users
  
  accepts_nested_attributes_for :address, :contact, :users, :allow_destoy => true
end