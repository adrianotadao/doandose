Rails.application.config.middleware.use OmniAuth::Builder do  
    provider :twitter, '7w827boomv26RP0rOleoQ', 'MsOi2yzJYXqLOsQs5bs72ZOzPOCgTPSAsRKrbClaE'  
    provider :google_oauth2, '419731615326.apps.googleusercontent.com', 'TYqSi86OuJqMmVVJpmIFvM4v'  
    provider :facebook, '396084903744192', 'cc93b21b9712bf746f9309e17f8fe86b'
    provider :identity  
end  
