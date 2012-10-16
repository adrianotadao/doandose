module MandrillMailer
  module Sender
    def method_missing(method_name, *args)
      if action_methods.include?(method_name.to_s)
        Message.new(self, method_name, *args)
      else
        super
      end
    end
  end

  class Message
    def initialize(mailer_class, method_name, *args)
      @mailer_class = mailer_class
      @method_name = method_name
      *@args = *args
    end

    def actual_message
      @actual_message ||= @mailer_class.send(:new, @method_name, *@args).message
    end

    def message_hash
      message = {
        subject: actual_message.subject,
        from_email: actual_message.from.join(';'),
        to: actual_message.to.map{ |r| {email: r} }
      }
      if actual_message.content_type.match(/text\/plain/)
        message[:text] = actual_message.body.to_s
      else
        message[:html] = actual_message.body.to_s
      end
      message
    end

    def deliver
      MandrillMailer::API.call :messages, :send, {message: message_hash}
    end
  end
end