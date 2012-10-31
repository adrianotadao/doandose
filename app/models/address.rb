class Address
  # Includes
  include Mongoid::Document
  include Mongoid::Timestamps

  # Fields
  field :number, type: String
  field :street, type: String
  field :neighborhood, type: String
  field :city, type: String
  field :zip_code, type: String
  field :state, type: String
  field :complement, type: String
  field :loc, type: Array, default: []

  # Accessors
  attr_accessor :lat, :lng

  # Relationships
  belongs_to :addressable, polymorphic: true

  # Validations
  validates_presence_of :zip_code, :number, :street, :neighborhood, :city,
    :state
  validates :number, numericality: true

  # Access control
  attr_accessible :number, :street, :neighborhood, :city, :zip_code, :state,
    :complement, :lat, :lng, :loc

  # Scopes
  scope :people, where: { addressable_type: 'Person' }
  scope :companies, where: { addressable_type: 'Company' }

  # Callbacks
  before_validation :parse_location

  # Others
  def formated_address
    "#{street}, #{neighborhood} - #{number}, #{city} - #{state}"
  end

  def parse_location
    return if self.lat.blank? || self.lng.blank?
    self.loc = [self.lat.to_f, self.lng.to_f]
  end

  def full_coordinate
    return if loc.blank?
    "#{self.loc[0]}, #{self.loc[1]}"
  end
end