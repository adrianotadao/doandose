class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include OmniAuth::Identity::Models::Mongoid

  has_secure_password

  field :email, type: String, case_sensitive: false
  field :password_digest, type: String
  field :reset_password_token, type: String
  field :reset_password_sent_at, type: Time
  index({ email: 1}, {unique: true})

  #associations
  belongs_to :authenticable, polymorphic: true
  belongs_to :company
  belongs_to :people
  has_many :authentications, dependent: :destroy, inverse_of: :user, autosave: true, class_name: 'Authentication'

  accepts_nested_attributes_for :authentications, :authenticable, allow_destroy: true

  #attributes
  attr_reader :password

  #validates
  validates_presence_of :email
  validates_associated :authentications, if: :authentications?
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: /^([^@\s]+[a-zA-Z0-9._-])@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  # callbacks
  after_save :build_identity

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end

  def build_identity
    return if password.blank?
    authentications.find_or_create_by(:provider => 'identity', :uid => id.to_s)
  end

  def authentications?
    authentications.to_a.present?
  end

  def self.locate(key)
    self.any_of({ :username => key }, { :email => key }).first
  end

  def add_authentication(auth)
    self.tap do |user|
      user.authentications.new(:provider => auth.provider, :uid => auth.uid)
      user.save
    end
  end

  def prepare_to_reset_password!
    generate_token!(:reset_password_token)
  end

  def password_is_reseted!
    self.update_attributes(:reset_password_token => nil)
  end

  def generate_token!(field)
    self.update_attributes(field => Digest::MD5.hexdigest("#{UsersFeatures.application_token}-#{email}-#{Time.now.to_i}"))
  end

  # static
  class << self
    def parse_omniauth(oauth)
      {
        :state => :new,
        :email => oauth.info.email,
        :username => oauth.info.nickname,
        :gender => self.define_gender(oauth),
        :authentication => {
          :provider => oauth.provider,
          :uid => oauth.uid
        }
      }
    end

    def social_networks(user)
      p user.authentications
      p user.authentications.map{ |auth| auth.provider}.join(',')
      p 'user -------------------------------'

      user.authentications.map{ |auth| auth.provider}.join(',') if user
    end

    def define_gender(oauth)
      return if oauth.extra.raw_info.gender.blank?
      oauth.extra.raw_info.gender.eql?('male') ? 'm' : 'f'
    end
  end

  def self.locate(key)
    self.any_of({ username: key }, { email: key }).first
  end
end
