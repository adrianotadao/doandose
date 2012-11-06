namespace :development do
  namespace :prepare do
    desc 'Prepare the development environment do work'
    task run: :environment do
      system <<-CPCMD
        cp #{Rails.root}/config/server/development/application.yml #{Rails.root}/config/application.yml
        cp #{Rails.root}/config/server/development/mongoid.yml #{Rails.root}/config/mongoid.yml
        cp #{Rails.root}/config/server/development/resque.yml #{Rails.root}/config/resque.yml
      CPCMD

      system 'rake db:populate'

    end
  end
end