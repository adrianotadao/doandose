class User

  include Mongoid::Document
  include Mongoid::Timestamps
  include OmniAuth::Identity::Model

  field :name, :type => String
  field :email, :type => String
  field :password_digest, :type => String
  field :reset_password_token, :type => String
  field :reset_password_sent_at, :type => Date

  #relationship
  belongs_to :authenticatable, polymorphic: true
  has_one :person
  has_many :authentications, dependent: :destroy, inverse_of: :user, autosave: :true

  accepts_nested_attributes_for :authentications, :allow_destroy => true    

  #validations
  validates_presence_of :email
  validates_presence_of :password, :if => :password_is_required?
  validates_confirmation_of :password, :if => :password?
  
  #others
  def password_is_required?
    true
  end

end
