class User

  include Mongoid::Document
  include Mongoid::Timestamps
  include OmniAuth::Identity::Model

  field :name, :type => String
  field :email, :type => String
  field :password_digest, :type => String
  field :reset_password_token, :type => String
  field :reset_password_sent_at, :type => Date

  attr_reader :password

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
    false
  end
  
  def password?
    password.present?
  end
  
  # Encrypts the password into the password_digest attribute.
  def password=(unencrypted_password)
  #     @password = unencrypted_password
  #     unless unencrypted_password.blank?
  #       self.password_digest = BCrypt::Password.create(unencrypted_password)
  #     end
  end
  
  def add_authentication(auth)
    self.tap do |user|
      user.authentications.new(:provider => auth.provider, :uid => auth.uid)
      user.save
    end
  end

  def has_identity?
    self.authentications.map(&:provider).include?('identity') || self.authentications.blank?
  end

  def add_authentication(auth)
    self.tap do |user|
      user.authentications.new(:provider => auth.provider, :uid => auth.uid)
      user.save
    end
  end

  def authentications?
    authentications.to_a.present?
  end

end
