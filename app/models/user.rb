class User
  include MongoMapper::Document
  
  key :active, Boolean
  key :donor, Boolean
  key :name, String
  key :surname, String
  key :sex, String
  key :weight, String
  key :height, String
  key :age, Integer
  key :blood_type, String

  key :email, String
  key :phone, String
  key :cellphone, String
  key :public_email, Boolean
  key :public_phone, Boolean
  key :public_cellphone, Boolean
  
  key :observations, String
      
  key :number, String
  key :address, String
  key :neighborhood, String
  key :city, String
  key :postal_code, String

  key :created_at, Time
  key :updated_at, Time
  
  key :lat, String
  key :lng, String
  
  #validations
  validates_presence_of :name, :surname, :sex, :weight, :height, :age, :blood_type, :email, :cep
  
end