Rails.application.config.middleware.use OmniAuth::Builder do |config|
    provider :twitter, Settings.social.twitter.key, Settings.social.twitter.secret
    provider :google_oauth2, Settings.social.google.key, Settings.social.google.secret
    provider :facebook, Settings.social.facebook.key, Settings.social.facebook.secret
    provider :identity, fields: [:email], model: User
    provider :developer if Rails.env.development?

    OmniAuth::config.on_failure = Proc.new { |env|
      OmniAuth::FailureEndpoint.new(env).redirect_to_failure
    }

end