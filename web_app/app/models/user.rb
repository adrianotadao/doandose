class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, :type => String
  field :password_digest, :type => String
  field :reset_password_token, :type => String
  field :reset_password_sent_at, :type => Date

  #relationship
  has_one :person
  has_many :authentications, dependent: :destroy, inverse_of: :user, autosave: :true

  accepts_nested_attributes_for :authentications, :allow_destroy => true    

end


