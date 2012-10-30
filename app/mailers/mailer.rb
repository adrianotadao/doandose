# encoding: utf-8
class Mailer < ActionMailer::Base
  layout 'mailer'
  include MandrillMailer

  default from: 'suporte@doando.se'
  def contact(contact)
    @contact = contact
    mail subject: contact.subject, to: Settings.contact_email, reply_to: contact.email
  end

  def reset_password_instructions(user_id)
    @user = User.find(user_id)
    @link = users_edit_password_url(@user.reset_password_token)
    mail subject: 'Esqueceu a Senha?', to: @user.email
  end

  def indication_friend(friend)
    @friend = friend
    mail subject: friend.subject, to: friend.sender, reply_to: friend.email
  end
end