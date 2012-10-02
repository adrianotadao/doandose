namespace :db do
  task populate: :environment do
    system 'rake db:drop; rake db:create; rake db:migrate; rake db:seed'
  end
end