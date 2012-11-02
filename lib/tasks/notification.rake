namespace :notification do
  task email_to_canceleds: :environment do
    for notification in Notification.actives
      for person_notification in notification.person_notifications.canceleds
        if person_notification.canceled_at > Time.now + 2.hours
          Resque.enqueue(PersonNotifications::ResendingEmail, person_notification.id)
        end
      end
    end
  end
end