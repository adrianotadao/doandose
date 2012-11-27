#encoding: utf-8
class Notifications::SMS
  @queue = "sms_notification_#{Rails.env}"

  def self.perform(notification_id)
    notification = Notification.find(notification_id)
    person_notifications = notification.person_notifications

    unless person_notifications.blank?
      person_notifications.each do |person_notification|
        if person_notification.person.contact.cellphone?
          person_notification.alerted_with << { source: 'sms', date: Time.now }
          person_notification.save
        end
      end
    end

    sms_numbers = person_notifications.map(&:person).map(&:contact).map{|r| r.parse_to_twilio if r.cellphone?}.compact

    #ContactTwilio.send_sms(sms_numbers, "Precisamos de sua doacao mais detalhes em #{Settings.domain}#{notification.slug}")
  end
end