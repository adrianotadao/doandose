class Authentication
  include Mongoid::Document
  include Mongoid::Timestamps

  # attributes
  belongs_to :user, class_name: 'User'
  field :provider
  field :uid

  index({ provider: 1})
  index({ uid: 1})
  index({ provider: 1, uid: 1})

  # validations
  validates_presence_of :uid, :provider, :user
  validates_uniqueness_of :provider, scope: :user_id
  validates_uniqueness_of :uid, scope: :provider
  validates_inclusion_of :provider, in: %w(identity facebook twitter windowslive google)
end