class Identity
  include Mongoid::Document
  include OmniAuth::Identity::Models::Mongoid
  field :name, :type => String
  field :email, :type => String
  field :password_digest, :type => String

  

  belongs_to :authenticatable, polymorphic: true
  has_one :person
  has_many :authentications, dependent: :destroy, inverse_of: :user, autosave: :true
end
