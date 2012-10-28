class PersonNotification
  include Mongoid::Document

  field :confirmed_at, type: Time
  field :canceled_at, type: Time
  field :alerted_at, type: Time
  field :alerted_with, type: Array, default: []

  #access control
  attr_accessible :alerted_at, :canceled_at, :confirmed_at, :person_id,
    :notification_id, :person, :notification

  #relationship
  belongs_to :person
  belongs_to :notification

  #validations
  validates_presence_of :person, :notification

  #scope
  scope :is_confimed, lambda { |person_id| where(person_id: person_id ) }

  #callbacks
  after_create :send_email

  def send_email
    return unless self.notification.blank?
    PersonNotificationMailer.confirmation(self.notification.id).deliver
  end


end