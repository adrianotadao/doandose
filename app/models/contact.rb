class Contact
  include Mongoid::Document
  include Mongoid::Timestamps

  field :phone, :type => String
  field :cellphone, :type => String
  field :email, :type => String

  #validations
  validates_presence_of :phone, :unless => :cellphone?
  validates_presence_of :cellphone, :unless => :phone?

  #relationship
  belongs_to :contactable, polymorphic: true
end