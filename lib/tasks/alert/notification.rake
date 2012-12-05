namespace :alert do
  namespace :notification do

    puts 'Observe notifications canceled and firing emails'
    task email_to_canceleds: :environment do
      for notification in Notification.actives
        for person_notification in notification.person_notifications.canceleds
          if person_notification.canceled_at.to_date > (Time.now + 2.hours).to_date
            #Resque.enqueue(PersonNotifications::ResendingEmail, person_notification.id)
          end
        end
      end
    end
  end
end