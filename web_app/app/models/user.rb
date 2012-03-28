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
  validates_uniqueness_of :email  
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i 
  validates_presence_of :password, :if => :password_is_required?
  validates_confirmation_of :password, :if => :password?
  
  #others
  def self.from_omniauth(auth)  
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)  
  end  
  
  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.provider = auth["provider"]  
      user.uid = auth["uid"]  
      user.name = auth["info"]["name"]  
    end  
  end  

  def build_identity
    authentications.find_or_create_by(:provider => 'identity', :uid => id.to_s) unless password.blank?
  end

  def add_url_protocol
    if self.site and !self.site[/^(http|https):\/\//]
      self.site = 'http://' + self.site
    end
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

  def authenticate(unencrypted_password)
    return false if password_digest.blank? || unencrypted_password.blank?
    
    if BCrypt::Password.new(password_digest) == unencrypted_password
      self
    else
      false
    end
  end

  def password=(unencrypted_password)
    @password = unencrypted_password
    unless unencrypted_password.blank?
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  class << self
    def new_with_omniauth(auth)
      User.new.tap do |user|
        user.email = auth.info.email
        user.username = auth.info.nickname
        user.city = auth.info.location
        
        if auth.info.urls.present? && auth.info.urls.first.present?
          user.site = auth.info.urls.first.last
        end

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

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end
end
