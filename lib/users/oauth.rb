module Users
  
  module OAuth
    mattr_accessor :twitter
    @@twitter = {}
    
    mattr_accessor :facebook
    @@facebook = {}
    
    mattr_accessor :google
    @@google = {}
    
    def self.load!
      Rails.application.config.middleware.use OmniAuth::Builder do
        if @@twitter.present?
          require 'omniauth-twitter'
          provider :twitter, @@twitter[:key], @@twitter[:secret]
        end
        
        if @@facebook.present?
          require 'omniauth-facebook'
          provider :facebook, @@facebook[:key], @@facebook[:secret]
        end
        
        if @@google.present?
          require 'omniauth-google-oauth2'
          provider :google_oauth2, @@google[:key], @@google[:secret], :name => 'google'
        end
        
        provider :identity, :fields => [:email, :username], :model => User
        provider :developer if Rails.env.development?
      end
    end
  
  end
end