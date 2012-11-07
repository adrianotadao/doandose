namespace :development do
  namespace :populate do
    task run: :environment do
      system 'rake db:drop --trace; rake db:create --trace; rake db:migrate --trace; rake db:seed --trace'
    end
  end
end