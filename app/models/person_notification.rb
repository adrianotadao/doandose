class PersonNotification
  include Mongoid::Document

  field :confirmed_at, type: Time

  #access control
  attr_accessible :confirmed_at, :person_id, :notification_id

  #relationship
  belongs_to :person
  belongs_to :notification

  #validations
  validates_presence_of :person, :notification

  #scope
  scope :is_confimed, lambda { |person_id| where(person_id: person_id ) }
end