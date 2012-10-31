class Alert
  include Mongoid::Document
  include Mongoid::Timestamps

  field :confirmed_at, type: Time
  field :canceled_at, type: Time
  field :alerted_at, type: Time
  field :alerted_with, type: Array, default: []

  # Access control
  attr_accessible :alerted_at, :canceled_at, :confirmed_at, :person_id,
    :person

  # Relationships
  belongs_to :person

  # Scopes
  scope :is_confimed, lambda { |person_id| where(person_id: person_id ) }

  # Validations
  validates_presence_of :person

end