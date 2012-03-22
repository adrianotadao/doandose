class Contact
  include Mongoid::Document
  
  field :email, :type => String
  field :phone, :type => String
  field :cellphone, :type => String
  field :public_email, :type => Boolean
  field :public_phone, :type => Boolean
  field :public_cellphone, :type => Boolean
end