# encoding: utf-8
class Mailer < ActionMailer::Base
  layout 'mailer'
  include MandrillMailer

  default from: 'suporte@doando.se'

  def contact(contact)
    @contact = contact
    mail subject: contact.subject, to: Settings.contact_email, reply_to: contact.email
  end

  def indication_friend(friend)
    @friend = friend
    mail subject: friend.subject, to: friend.sender, reply_to: friend.email
  end
end