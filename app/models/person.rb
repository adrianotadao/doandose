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

  field :lat, :type => String
  field :lng, :type => String

  #relationship
  belongs_to :blood
  has_one :address, as: :addressable, dependent: :destroy
  has_one :contact, as: :contactable, dependent: :destroy
  has_one :user, as: :authenticatable, dependent: :destroy
  has_many :person_notifications

  #validations
  validates_presence_of :name, :surname, :sex, :birthday, :blood, :contact, :address, :user, :lat, :lng
  validates_associated :contact, :address, :user

  accepts_nested_attributes_for :address, :contact, :user, :allow_destoy => true

  attr_accessible :address, :contact, :user

end
