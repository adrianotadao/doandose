source 'http://rubygems.org'

gem 'rails', '3.1.3'
gem 'mongo'
gem 'mongoid', '~> 2.4'
gem 'bson_ext', '~> 1.5'

gem 'jquery-rails'
gem 'haml', '~> 3.1.4'
gem 'simple_form', '1.5.2'
gem 'settingslogic', '2.0.6'
gem 'awesome_nested_fields', '0.5.3'

gem 'paperclip', '2.7.0'
gem 'mongoid-paperclip', :require => "mongoid_paperclip"

gem 'bcrypt-ruby', '~> 3.0.0'  
gem 'omniauth-twitter'  
gem 'omniauth-facebook'  
gem 'omniauth-google-oauth2'  
gem 'omniauth-identity'    
gem "omniauth"  

gem 'rspec', '2.8', :group => [:test, :development]

group :assets do
  gem 'compass-rails'
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test do
  gem 'spork', '0.9.0'
  gem 'database_cleaner', '0.7.1'
  gem 'ffaker', '1.12.1'
  gem 'fabrication', '1.3.1'
  gem 'guard-rspec', '0.6.0'
  gem 'guard-bundler', '0.1.3'
  gem 'guard-spork', '0.5.2'

  if RUBY_PLATFORM.downcase.include?("darwin")
    gem 'rb-fsevent', '0.9.0'
    gem 'growl', '1.0.3'
  end

  if RUBY_PLATFORM.downcase.include?("linux")
    gem 'rb-inotify', '0.8.6'
    #gem 'libnotify', '0.5.2'
    gem 'libnotify', '0.7.2'
  end
end