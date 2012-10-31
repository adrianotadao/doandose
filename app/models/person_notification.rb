class PersonNotification < Alert
  # Relationships
  belongs_to :notification

  # Access control
  attr_accessible :notification_id, :notification

  # Validations
  validates_presence_of :notification

  # Callbacks
  #after_create :send_email_confirmation
  after_destroy :send_email_undo_confirm

  # Others
  def send_email_undo_confirm
    return if self.notification.blank? && self.person.blank?
    CompanyNotificationMailer.undo_confirmation(self.notification.id, self.person.id).deliver
  end

  def send_email_confirmation
    return if self.notification.blank?
    CompanyNotificationMailer.confirmation(self.notification.id).deliver
  end

end