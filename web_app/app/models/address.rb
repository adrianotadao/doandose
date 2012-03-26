class Address

  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :number, :type => String
  field :street, :type => String
  field :neighborhood, :type => String
  field :city, :type => String
  field :postal_code, :type => String
  field :state, :type => String

  #relationship
  has_many :user

end