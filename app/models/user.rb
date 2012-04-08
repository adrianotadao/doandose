class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include OmniAuth::Identity::Model

  #associations
  belongs_to :authenticatable, polymorphic: true
  has_many :authentications, dependent: :destroy, inverse_of: :user, autosave: true 
  has_many :people

  #attributes
  field :username, type: String, case_sensitive: false
  field :email, type: String, case_sensitive: false
  field :password_digest, type: String

  index :username
  index :email

  accepts_nested_attributes_for :authentications, :allow_destroy => true

  # callbacks
  after_save :build_identity

  attr_accessible :email, :password, :password_confirmation  

  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.provider = auth["provider"]  
      user.uid = auth["uid"]  
      user.name = auth["user_info"]["name"]  
    end  
  end  

  def build_identity
    authentications.find_or_create_by(:provider => 'identity', :uid => id.to_s) unless password.blank?
  end

  def has_identity?
    self.authentications.map(&:provider).include?('identity') || self.authentications.blank?
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
