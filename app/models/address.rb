class Address

  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :number, :type => String
  field :street, :type => String
  field :neighborhood, :type => String
  field :city, :type => String
  field :zip_code, :type => String
  field :state, :type => String
  field :complement, :type => String
  field :lat, :type => Float
  field :lng, :type => Float

  #access control
  attr_accessible :number, :street, :neighborhood, :city, :zip_code, :state, :complement

  #relationship
  belongs_to :addressable, polymorphic: true
  
  #validations
  validates_presence_of :zip_code, :number, :street, :neighborhood, :city, :state, :lat, :lng

  def full_coordenation
    "#{self.lat}, #{self.lng}" if self.lat && self.lng
  end
end
