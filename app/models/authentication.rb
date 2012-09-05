class Authentication
  include Mongoid::Document
  include Mongoid::Timestamps

  # attributes
  field :provider
  field :uid

  index :provider
  index :uid
  index [:provider, :uid]

  belongs_to :user

  # validations
  validates_presence_of :uid, :provider, :user
  validates_uniqueness_of :provider, :scope => :user
  validates_uniqueness_of :uid, :scope => :provider
end