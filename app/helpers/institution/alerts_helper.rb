module Institution::AlertsHelper
  def can_send_email(person_notification)
    person_notification.last_email > (Time.now - 1.hours)
  end

  def can_send_sms(person_notification)
    person_notification.last_sms > (Time.now - 1.hours)
  end
end