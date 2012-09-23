class Notification
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :active, type: Boolean
  field :quantity, type: Integer
  field :situation, type: String
  field :title, type: String
  field :observation, type: String
  field :permalink, type: String
  field :alerted_at, type: Time

  slug :permalink

  #relationship
  belongs_to :company
  belongs_to :blood
  has_many :person_notifications

  accepts_nested_attributes_for :person_notifications, allow_destroy: true

  #access control
  attr_accessible :quantity, :situation, :alerted_at, :active, :blood_id, :company_id, :title, :observation, :permalink, :person_notifications_attributes

  #validations
  validates_presence_of :company, :blood, :situation, :quantity, :alerted_at

  #scopes
  scope :actives, where(active: true)

end