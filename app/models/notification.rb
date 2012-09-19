class Notification
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :active, type: Boolean
  field :quantity, type: Integer
  field :situation, type: String
  field :denomination, type: String
  field :observation, type: String
  field :alerted_at, type: Time

  slug :situation

  #relationship
  belongs_to :company
  belongs_to :blood
  has_many :person_notifications

  #access control
  attr_accessible :quantity, :situation, :alerted_at, :active, :blood, :company

  #validations
  validates_presence_of :company, :blood, :situation, :quantity, :alerted_at
end