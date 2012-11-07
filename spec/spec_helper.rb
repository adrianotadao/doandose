require 'spork'

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV['RACK_ENV'] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'database_cleaner'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[File.expand_path '../support/**/*.rb',  __FILE__].each { |f| require f }

  RSpec.configure do |config|
    config.mock_with :rspec

    config.before(:suite) do
      DatabaseCleaner[:mongoid].strategy = :truncation
      DatabaseCleaner[:mongoid].clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
end

Spork.each_run do
  FactoryGirl.find_definitions
  FactoryGirl.factories.clear
  FactoryGirl.reload
end