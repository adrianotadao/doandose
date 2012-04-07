class Authentication
  include Mongoid::Document
  include Mongoid::Timestamps

  # attributes
  belongs_to :user
  field :provider
  field :uid

  index :provider
  index :uid
  index [:provider, :uid]
  
  # validations
  validates_presence_of :uid, :provider, :user
  validates_uniqueness_of :provider, :scope => :user
  validates_uniqueness_of :uid, :scope => :provider
end
