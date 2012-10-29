# encoding: utf-8
class CompanyNotificationMailer < ActionMailer::Base
  layout 'mailer'
  include MandrillMailer

  default from: 'suporte@doando.se'

  def alerting(id)
    @person_notification = PersonNotification.find(id)
    mail subject: "Foi criada uma nova notificação na qual precisam de você #{@notification.title}", to: @person_notification.person.contact.email
  end

  def confirmation(notification_id)
    @notification = Notification.find(notification_id)
    mail subject: "+ 1 voluntario confirmou a presenca referente a notificacao #{@notification.title}", to: @notification.company.contact.email
  end

  def undo_confirmation(notification_id, person_id)
    @notification = Notification.find(notification_id)
    mail subject: "Cancelamento de um participante da notificacao: #{@notification.title}", to: @notification.company.contact.email
  end
end