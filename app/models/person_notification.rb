class PersonNotification < Alert
  # Relationships
  belongs_to :notification
  belongs_to :person

  # Access control
  attr_accessible :notification_id, :notification, :person_id, :person

  # Validations
  validates_presence_of :notification, :person

  # Callbacks
  after_save :send_email

  # Scopes
  scope :notification_contains,  lambda { |notification_id| where( notification_id: notification_id ) }

  # Others
  def send_email
    return if self.notification.blank? && self.person.blank?
    if self.canceled?
      CompanyNotificationMailer.undo_confirmation(self.notification.id, self.person.id).deliver
    else
      CompanyNotificationMailer.confirmation(self.notification.id).deliver
    end
  end

  def non_canceled?
    self.canceled_at.blank?
  end

  def canceled?
    self.canceled_at.present?
  end
end