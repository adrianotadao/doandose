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
  
  # Encrypts the password into the password_digest attribute.
  def password=(unencrypted_password)
    @password = unencrypted_password
    unless unencrypted_password.blank?
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end
  
  # Add new authentication when users have other authentication
  def add_authentication(auth)
    self.tap do |user|
      user.authentications.new(:provider => auth.provider, :uid => auth.uid)
      user.save
    end
  end
  
  #static
  class << self
    def new_with_omniauth(auth)
      User.new.tap do |user|
        user.email = auth.info.email
        user.authentications.new(:provider => auth.provider, :uid => auth.uid)
      end
    end
  end

end
