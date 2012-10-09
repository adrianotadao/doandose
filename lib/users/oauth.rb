module Users
  module OAuth
    mattr_accessor :twitter
    @@twitter = {}

    mattr_accessor :facebook
    @@facebook = {}

    mattr_accessor :google
    @@google = {}

    mattr_accessor :windowslive
    @@windowslive = {}

    def self.load!
      Rails.application.config.middleware.use OmniAuth::Builder do
        if @@twitter.present?
          require 'omniauth-twitter'
          provider :twitter, @@twitter[:key], @@twitter[:secret]
        end

        if @@facebook.present?
          require 'omniauth-facebook'
          provider :facebook, @@facebook[:key], @@facebook[:secret], :display => 'popup'
        end

        if @@google.present?
          require 'omniauth-google-oauth2'
          provider :google_oauth2, @@google[:key], @@google[:secret], :name => 'google'
        end

        if @@windowslive.present?
          require 'omniauth-windowslive'
          provider :windowslive, @@windowslive[:key], @@windowslive[:secret], :scope => 'wl.basic'
        end
        provider :identity, :fields => [:email, :username], :model => Users::User

        provider :developer if Rails.env.development?

        OmniAuth.config.on_failure = Proc.new { |env|
          p 'omniauth ----------------------'
          OmniAuth::FailureEndpoint.new(env).redirect_to_failure
        }
      end
    end
  end
end