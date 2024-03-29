require 'spork'

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV['RACK_ENV'] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'factory_girl'
  require 'rspec/rails'
  require 'database_cleaner'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  Mongoid.load!('./spec/support/mongoid.yml')

  RSpec.configure do |config|
    config.mock_with :rspec

    config.include SpecTestHelper, :type => :controller

    config.before(:suite) do
      DatabaseCleaner.orm = :mongoid
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean_with(:truncation)
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