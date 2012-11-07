class PersonNotifications::Confirmation
  @queue = "email_confirmation_person_notification_#{Rails.env}"

  def self.perform(notification_id)
    return unless notification_id

    PersonNotificationMailer.confirmation(notification_id).deliver
  end
end