class Blood
  include Mongoid::Document
  include Mongoid::Slug

  field :name, :type => String

  slug :name

  #relationship
  has_many :people
  has_many :notifications

  #validations
  validates_presence_of :name
  validates_uniqueness_of :name
end