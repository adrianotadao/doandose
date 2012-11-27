#encoding: utf-8
class PersonNotifications::SMS
  @queue = "sms_person_notification_#{Rails.env}"

  def self.perform(person_notification_id)
    person_notification = PersonNotification.find(person_notification_id)

    return unless person_notification

    person_notification.alerted_with << { source: 'sms', date: Time.now }
    person_notification.save

    call_number = person_notification.person.contact.parse_to_twilio

    #ContactTwilio.send_sms([call_number], "Precisamos de sua doacao mais detalhes em #{Settings.domain}#{person_notification.notification.slug}")
  end
end