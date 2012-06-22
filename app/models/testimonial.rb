class Testimonial

  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :active, :type => Boolean, :default => false
  field :name, :type => String
  field :body, :type => String
  
  #access control
  attr_accessible :name, :body
  
  #relationship
  belongs_to :person
  belongs_to :company

  #validations
  validates_presence_of :person, :unless => :company
  validates_presence_of :company, :unless => :person
  validates_presence_of :name, :body
end