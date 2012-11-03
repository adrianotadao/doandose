class PersonNotifications::Email
  @queue = "email_person_notification_#{Rails.env}"

  def self.perform(person_notification_id)
    person_notification = PersonNotification.find(person_notification_id)

    return unless person_notification

    person_notification.alerted_with << { source: 'email', date: Time.now }
    person_notification.save
    #PersonNotificationMailer.alerting(id).deliver
  end
end