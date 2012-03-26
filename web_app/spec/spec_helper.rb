require 'spork'

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV['RACK_ENV'] ||= 'test'
  require 'rspec'
  require 'database_cleaner'
  require 'ffaker'
  require 'rubygems'
  require 'bundler/setup'
  Bundler.require
  require 'fabrication'
      
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Mongoid.load! File.expand_path('../support/mongoid.yml',  __FILE__)
  Dir[File.expand_path '../support/**/*.rb',  __FILE__].each { |f| require f }
  Dir[File.expand_path '../../app/models/**/*.rb',  __FILE__].each { |f| load f }
  Dir[File.expand_path '../fabricators/**/*.rb',  __FILE__].each { |f| require f }

  RSpec.configure do |config|
    config.mock_with :rspec

    config.before(:suite) do
      Dir[File.expand_path '../../app/models/**/*.rb',  __FILE__].each { |f| require f }
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

Spork.each_run do |config|
  Fabrication.clear_definitions
end if Spork.using_spork?