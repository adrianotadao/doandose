require 'users/engine'
require 'mongoid/railtie'
require 'omniauth'
require 'omniauth-identity'
require 'haml'
require 'bcrypt'

module Users
  autoload :OAuth,   'users/oauth'
  
  # Default way to setup
  def self.setup
    yield self
  end
  
  def self.omniauth
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
end
