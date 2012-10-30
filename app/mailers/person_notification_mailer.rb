# encoding: utf-8
class PersonNotificationMailer < ActionMailer::Base
  layout 'mailer'
  include MandrillMailer

  default from: 'suporte@doando.se'

  def confirmation(notification_id)
    @notification = Notification.find(notification_id)
    mail subject: "Obrigado por participar #{@notification.title}", to: current_user.email
  end
end