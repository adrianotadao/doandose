Rails.application.config.middleware.use OmniAuth::Builder do  
    provider :twitter, '7w827boomv26RP0rOleoQ', 'MsOi2yzJYXqLOsQs5bs72ZOzPOCgTPSAsRKrbClaE'  
    provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']  
    provider :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET']  
    provider :identity  
end  
