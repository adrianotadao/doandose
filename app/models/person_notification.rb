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
  after_create :send_email_confirmation
  after_destroy :send__email_undo_confirm

  def send__email_undo_confirm
    return if self.notification.blank? && self.person.blank?
    CompanyNotificationMailer.undo_confirmation(self.notification.id, self.person.id).deliver
  end

  def send_email
    return if self.notification.blank?
    CompanyNotificationMailer.confirmation(self.notification.id).deliver
  end


end