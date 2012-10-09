require 'users/session'
require 'users/oauth'
require 'users/engine'
require 'users/config'
require 'mongoid/railtie'
require 'omniauth'
require 'omniauth-identity'
require 'haml'
require 'bcrypt'
require 'active_record'



module Users
  def self.setup
    p 'self ----------------------'
    yield self
  end

  def self.omniauth
    p 'self 2 ----------------------'
    yield OAuth
    OAuth.load!
  end

   # Paths
    mattr_accessor :after_login_path
    @@after_login_path = '/'

    mattr_accessor :after_logout_path
    @@after_logout_path = '/'

    mattr_accessor :after_registration_path
    @@after_registration_path = '/'

    mattr_accessor :avatar_path
    @@avatar_path = 'dl'

    mattr_accessor :avatar_url
    @@avatar_url = '/dl'

    mattr_accessor :base_layout
    @@application_layout = 'application'

    mattr_accessor :application_token
    @@application_token = '/'

    mattr_accessor :application_domain
    @@application_domain = 'localhost'
end