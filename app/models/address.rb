class Address
  include Mongoid::Document
  include Mongoid::Timestamps

  field :number, type: String
  field :street, type: String
  field :neighborhood, type: String
  field :city, type: String
  field :zip_code, type: String
  field :state, type: String
  field :complement, type: String
  field :lat, type: Float
  field :lng, type: Float

  #relationship
  belongs_to :addressable, polymorphic: true

  #validations
  validates_presence_of :zip_code, :number, :street, :neighborhood, :city, :state, :lat, :lng

  #access control
  attr_accessible :number, :street, :neighborhood, :city, :zip_code, :state, :complement, :lat, :lng

  #scopes
  scope :people, where: { addressable_type: 'Person' }
  scope :companies, where: { addressable_type: 'Company' }

  def full_coordinate
    return if lat.blank? || lng.blank?
    "#{self.lat}, #{self.lng}"
  end

  def set_lat_lng
    return if !self.lat.blank? && !self.lng.blank?
    coodinates = GMap.coordinates(address_for_geokit)
    self.lat = coodinates.lat
    self.lng = coodinates.lng
  end

  private
  def address_for_geokit
    "#{number} #{street}, #{neighborhood}, #{city} - #{state}".mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
  end
end