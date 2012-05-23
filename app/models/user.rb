class User
  require 'bcrypt'

  include Mongoid::Document
  include Mongoid::Timestamps
  include OmniAuth::Identity::Model

  #associations
  belongs_to :authenticable, polymorphic: true
  belongs_to :company
  belongs_to :people
  has_many :authentications, dependent: :destroy, inverse_of: :user, autosave: true
  
  #attributes
  attr_reader :password

  field :username, type: String, case_sensitive: false
  field :email, type: String, case_sensitive: false
  field :password_digest, type: String
  field :reset_password_token, :type => String
  field :reset_password_sent_at, :type => Time

  index :username
  index :email

  accepts_nested_attributes_for :authentications, :authenticable, :allow_destroy => true

  #validates
  validates_presence_of :email
  validates_presence_of :authentications, :unless => :password?
  validates_presence_of :password, :if => :password_is_required?
  validates_presence_of :password_digest, :if => :password?
  validates_uniqueness_of :email, :case_sensitive => false
  validates_associated :authentications, :if => :authentications?
  validates_confirmation_of :password, :if => :password?
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/  

  # callbacks
  after_save :build_identity

  def build_identity
    authentications.find_or_create_by(:provider => 'identity', :uid => id.to_s) unless password.blank?
  end

  def prepare_to_reset_password!
    self.update_attributes(:reset_password_token => Digest::MD5.hexdigest("#{TOKEN}-#{username}-#{DateTime.now.to_s}-#{Date.today.to_s}"))
  end
  
  def password_is_reseted!
    self.update_attributes(:reset_password_token => nil)
  end

  def add_authentication(auth)
    self.tap do |user|
      user.authentications.new(:provider => auth.provider, :uid => auth.uid)
      user.save
    end
  end
  
  def password?
    password.present?
  end
  
  def has_identity?
    self.authentications.map(&:provider).include?('identity') || self.authentications.blank?
  end
  
  def password_is_required?
    !reset_password_token_changed? && !reset_password_token.blank? || !authentications?
  end
  
  def authentications?
    authentications.to_a.present?
  end

  # Returns self if the password is correct, otherwise false.
  def authenticate(unencrypted_password)
    return false if password_digest.blank? || unencrypted_password.blank?
    
    if BCrypt::Password.new(password_digest) == unencrypted_password
      self
    else
      false
    end
  end

  # Encrypts the password into the password_digest attribute.
  def password=(unencrypted_password)
    @password = unencrypted_password
    unless unencrypted_password.blank?
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  # static
  class << self
    def new_with_omniauth(auth)
      User.new.tap do |user|
        user.email = auth.info.email
        user.username = auth.info.nickname
        user.authentications.new(:provider => auth.provider, :uid => auth.uid)
      end
    end
    
    def locate(key)
      self.any_of({ :username => key }, { :email => key }).first
    end
    
    def attributes_protected_by_default
      super + ['password_digest']
    end
  end

end
