class Person
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :active, :type => Boolean
  field :donor, :type => Boolean
  field :name, :type => String
  field :surname, :type => String
  field :sex, :type => String
  field :weight, :type => Float
  field :height, :type => Float
  field :birthday, :type => Date  
  field :observations, :type => String

  field :created_at, :type => Time
  field :updated_at, :type => Time
  
  field :lat, :type => String
  field :lng, :type => String

  #relationship
  has_one :address, dependent: :destroy
  belongs_to :blood
  has_one :contact, dependent: :destroy
  has_one :user, dependent: :destroy  

  #validations
  validates_presence_of :name, :surname, :sex, :birthday, :blood
  validates_associated :contact, :address, :user

  accepts_nested_attributes_for :addresses, :contacts, :allow_destoy => true

end
