class Address

  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :number, :type => String
  field :street, :type => String
  field :neighborhood, :type => String
  field :city, :type => String
  field :zip_code, :type => String
  field :state, :type => String

  #relationship
  belongs_to :addressable, polymorphic: true
  has_many :user
  
  #validations
  validates_presence_of :zip_code, :number, :street, :neighborhood, :city, :state

end