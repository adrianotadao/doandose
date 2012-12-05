class PersonNotification < Alert
  # Relationships
  belongs_to :notification
  belongs_to :person

  # Access control
  attr_accessible :notification_id, :notification, :person_id, :person

  # Validations
  validates_presence_of :notification

  # Callbacks
  after_create :send_email
  after_update :undo_confirmation

  # Scopes
  scope :notification_contains,  lambda { |notification_id| where( notification_id: notification_id ) }
  scope :person_notification_count, lambda{ |notification_id| where(notification_id: notification_id, canceled_at: '') }

  # Others
  def send_email
    if self.can_send_email
      Resque.enqueue(PersonNotifications::Email, id)
      Resque.enqueue(PersonNotifications::Confirmation, id)
    end
  end

  def undo_confirmation
    if self.canceled?
      Resque.enqueue(PersonNotifications::UndoConfirmation, id)
    end
  end

  def non_canceled?
    self.canceled_at.blank?
  end

  def canceled?
    self.canceled_at.present?
  end
end