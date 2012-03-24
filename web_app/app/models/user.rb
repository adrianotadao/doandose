class User
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :address

  field :donor, :type => Boolean
  field :name, :type => String
  field :surname, :type => String
  field :sex, :type => String
  field :weight, :type => String
  field :height, :type => String
  field :age, :type => String
  field :email, :type => String
  field :public_email, :type => Boolean
  field :phone, :type => String
  field :public_phone, :type => Boolean
  field :cellphone, :type => String
  field :public_cellphone, :type => Boolean
  field :observations, :type => String

end


