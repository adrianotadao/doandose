namespace :dropbox do 
  
  desc "Backup production database to dropbox"
  task :backup => :environment do
    require 'dropbox_sdk'
    
    #create's the mongo dump
    host, port = Mongoid.database.connection.host_to_try
    db_name =    Mongoid.database.name
    auths =      Mongoid.database.connection.auths
 
    if auths.length > 0
      auth_string = "-u #{auths[0]["username"]} -p #{auths[0]["password"]}"
    end
    
    dump_filename = Time.now.strftime("%m-%d-%Y_%H%M")
    cmd = "mongodump #{auth_string} --host #{host} --port #{port} -d #{db_name} -o db/mongodumps/#{Rails.env}/#{dump_filename}"
    puts "Running '#{cmd}'"
    `#{cmd}`
    system "tar -cvf db/mongodumps/#{Rails.env}/#{dump_filename}.tar db/mongodumps/#{Rails.env}/#{dump_filename}"
    system "gzip db/mongodumps/#{Rails.env}/#{dump_filename}.tar"
    system "rm -rf db/mongodumps/#{Rails.env}/#{dump_filename}"
        
    #get the dropbox conf parameters from the yml on the config folder    
    DROPBOX_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/dropbox.yml")[Rails.env]
    
    #check if a session file already exist's if not it create one
    unless File.exist? 'dropbox_session.txt'
      session = DropboxSession.new(DROPBOX_CONFIG["app_key"],DROPBOX_CONFIG["app_secret"])      
      puts "Visit #{session.get_authorize_url} to log in to Dropbox. Hit enter when you have done this."
      STDIN.gets
      session.get_access_token
    
      File.open('dropbox_session.txt', 'w') do |f|
        f.puts session.serialize
      end
    else
      session = DropboxSession.deserialize(File.read('dropbox_session.txt'))
      puts 'Stored session restored with success!'
    end
    #backup black magic happens
    client = DropboxClient.new(session, :app_folder)
    client.put_file("/#{dump_filename}.tar.gz", open("db/mongodumps/#{Rails.env}/#{dump_filename}.tar.gz"))
    system "rm -rf db/mongodumps/#{Rails.env}/#{dump_filename}.tar.gz"
    puts "Mongo Dump #{dump_filename} was uploaded to your dropbox remote folder"
  end
end