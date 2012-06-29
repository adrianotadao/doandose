if Settings.mail.delivery_method == 'smtp'
  ActionMailer::Base.smtp_settings = {
    :address => Settings.mail.address,
    :port => Settings.mail.port,
    :authentication => Settings.mail.authentication,
    :user_name => Settings.mail.username,
    :password => Settings.mail.password,
    :enable_starttls_auto => Settings.mail.enable_starttls_auto
  }
end