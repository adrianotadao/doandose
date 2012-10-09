Rails.application.config.middleware.use OmniAuth::Builder do |config|
    config.on_failure do
      redirect_to users_new_session_path
    end

    provider :developer unless Rails.env.production?
    provider :twitter, Settings.social.twitter.key, Settings.social.twitter.secret
    provider :google_oauth2, Settings.social.google.key, Settings.social.google.secret
    provider :facebook, Settings.social.facebook.key, Settings.social.facebook.secret

end