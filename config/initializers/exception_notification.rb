if defined?(ExceptionNotifier)
  ClickJogos::Application.config.middleware.use ExceptionNotifier,
    :email_prefix => '[EXCEPTION]',
    :sender_address => 'suporte@doando.se',
    :exception_recipients => 'exceptions@doando.se'
end