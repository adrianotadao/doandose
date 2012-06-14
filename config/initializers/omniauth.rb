Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, Settings.social.twitter.key, Settings.social.twitter.secret
    provider :google_oauth2, Settings.social.google.key, Settings.social.google.secret
    provider :facebook, Settings.social.facebook.key, Settings.social.facebook.secret
    provider :identity  
end
