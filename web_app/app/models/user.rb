class User
  include Mongoid::Document
  
  field :active, :type => Boolean
  field :donor, :type => Boolean
  field :name, :type => String
  field :surname, :type => String
  field :sex, :type => String
  field :weight, :type => String
  field :height, :type => String
  field :age, :type => Integer
  field :blood_type, :type => String

  field :email, :type => String
  field :phone, :type => String
  field :cellphone, :type => String
  field :public_email, :type => Boolean
  field :public_phone, :type => Boolean
  field :public_cellphone, :type => Boolean
  
  field :observations, :type => String

  field :number, :type => String
  field :address, :type => String
  field :neighborhood, :type => String
  field :city, :type => String
  field :postal_code, :type => String

  field :created_at, :type => Time
  field :updated_at, :type => Time
  
  field :lat, :type => String
  field :lng, :type => String
  
  #validations
  validates_presence_of :name, :surname, :sex, :weight, :height, :age, :blood_type, :email, :postal_code
  
end