namespace :development do
  namespace :populate do
    task run: :environment do
      system 'rake db:drop; rake db:create; rake db:migrate; rake db:seed'
    end
  end
end