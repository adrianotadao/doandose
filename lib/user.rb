require 'users/session'
require 'users/oauth'

require 'mongoid/railtie'
require 'omniauth'
require 'omniauth-identity'
require 'haml'
require 'bcrypt'
require 'active_record'

def self.setup
  yield self
end

def self.omniauth
  p 'asdfadsf ------------------------------'
  yield OAuth
  OAuth.load!
end