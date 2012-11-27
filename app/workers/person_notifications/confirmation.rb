class PersonNotifications::Confirmation
  @queue = "email_confirmation_person_notification_#{Rails.env}"

  def self.perform(person_notification_id)
    return unless person_notification_id
    PersonNotificationMailer.confirmation(person_notification_id).deliver
  end
end