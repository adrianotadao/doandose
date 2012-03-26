class Contact

  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :email, :type => String
  field :phone, :type => String
  field :cellphone, :type => String

  #validations
  validates_presence_of :email
  validates_presence_of :phone, :unless => :cellphone?
  validates_presence_of :cellphone, :unless => :phone?
  
end
