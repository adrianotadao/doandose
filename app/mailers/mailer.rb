# encoding: utf-8
class Mailer < ActionMailer::Base
  include MandrillMailer

  default :from => 'suporte@doando.se'

  def confirmation_participation(notification_id)
    @notification = Notification.find(notification_id)
    mail subject: "+ 1 voluntario confirmou a presenca referente a notificacao #{@notification.title}", to: @notification.company.contact.email
  end
end