class Person
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :active, :type => Boolean
  field :donor, :type => Boolean
  field :name, :type => String
  field :surname, :type => String
  field :sex, :type => String
  field :weight, :type => String
  field :height, :type => String
  field :age, :type => Integer
  field :blood_type, :type => String  
  field :observations, :type => String

  field :created_at, :type => Time
  field :updated_at, :type => Time
  
  field :lat, :type => String
  field :lng, :type => String
  
  #relationship
  has_one :address
  has_one :contact
  
  #validations
  validates_presence_of :name, :surname, :sex, :weight, :height, :age, :blood_type
  accepts_nested_attributes_for :address, :contact, :allow_destoy => true
end