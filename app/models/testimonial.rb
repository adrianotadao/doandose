class Testimonial
  # Includes
  include Mongoid::Document
  include Mongoid::Timestamps

  # Fields
  field :active, type: Boolean, default: false
  field :name, type: String
  field :body, type: String

  # Access control
  attr_accessible :name, :body

  # Relationships
  belongs_to :person
  belongs_to :company

  # Validations
  validates_presence_of :person, unless: :company
  validates_presence_of :company, unless: :person
  validates_presence_of :name, :body
end