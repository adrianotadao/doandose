namespace :db do
  desc "Dump Mongo DB based on mongoid.yml settings, orgnanized by Rails.env and timestamp."
  task :dump => :environment do
    host, port = Mongoid.database.connection.host_to_try
    db_name =    Mongoid.database.name
    auths =      Mongoid.database.connection.auths
 
    if auths.length > 0
      auth_string = "-u #{auths[0]["username"]} -p #{auths[0]["password"]}"
    end
    
    dump_filename = Time.now.to_i
    cmd = "mongodump #{auth_string} --host #{host} --port #{port} -d #{db_name} -o db/mongodumps/#{Rails.env}/#{dump_filename}"
    puts "Running '#{cmd}'"
    `#{cmd}`
    system "tar -cvf db/mongodumps/#{Rails.env}/#{dump_filename}.tar db/mongodumps/#{Rails.env}/#{dump_filename}"
    system "gzip db/mongodumps/#{Rails.env}/#{dump_filename}.tar"
    system "rm -rf db/mongodumps/#{Rails.env}/#{dump_filename}"
  end
end