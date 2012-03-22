class Address
  include Mongoid::Document
  
  field :number, :type => String
  field :address, :type => String
  field :neighborhood, :type => String
  field :city, :type => String
  field :postal_code, :type => String
end