class PersonNotification
  include Mongoid::Document

  field :confirmed_at, type: Time
  field :canceled_at, type: Time
  field :alerted_at, type: Time

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

  #callback
  after_create :send_confirmation_notification_email

  def send_confirmation_notification_email
    self.update_attributes(alerted_at: Time.now)
    #Mailer.alerting(id).deliver
  end
end