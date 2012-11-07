# encoding: utf-8
class PersonNotificationMailer < ActionMailer::Base
  layout 'mailer'
  include MandrillMailer

  default from: 'suporte@doando.se'

  def alerting(id)
    @person_notification = PersonNotification.find(id)
    mail subject: "Foi criada uma nova notificação na qual precisam de você #{@notification.title}", to: @person_notification.person.contact.email
  end

  def confirmed(notification_id)
    @notification = Notification.find(notification_id)
    mail subject: "Obrigado por participar #{@notification.title}", to: current_user.email
  end

  def confirmation(notification_id)
    @notification = Notification.find(notification_id)
    mail subject: "+ 1 voluntario se cadastrou na #{@notification.title}", to: @notification.company.email
  end

  def resending(id)
    @person_notification = PersonNotification.find(id)
    mail subject: "Pense com carinho nessa notificacao: #{@notification.title}", to: @person_notification.person.contact.email
  end

  def undo_confirmation(notification_id)
    @notification = Notification.find(notification_id)
    mail subject: "Cancelamento de um participante da notificacao: #{@notification.title}", to: @notification.company.contact.email
  end
end