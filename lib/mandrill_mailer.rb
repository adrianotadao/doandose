require 'mandrill_mailer/api'
require 'mandrill_mailer/sender'

module MandrillMailer
  def self.included(base)
    base.extend(MandrillMailer::Sender)
  end
end