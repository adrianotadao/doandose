class Authentication
  # Includes
  include Mongoid::Document
  include Mongoid::Timestamps

  # Fields
  field :provider, type: String
  field :uid, type: String

  # Indexes
  index({ provider: 1})
  index({ uid: 1})
  index({ provider: 1, uid: 1})

  # Relationships
  belongs_to :user, class_name: 'User'

  # Validations
  validates_presence_of :uid, :provider, :user
  validates_uniqueness_of :provider, scope: :user_id
  validates_uniqueness_of :uid, scope: :provider
  validates_inclusion_of :provider, in: %w(identity facebook twitter google_oauth2)
end