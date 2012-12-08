require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

scheduler.every '1h' do
  system('rake alert:campaign:hour')
  system('rake alert:notification:email_to_canceleds')
end

scheduler.cron '0 00 * * 1-5' do
  system('rake alert:campaign:day')
end

scheduler.cron '0 23 * * 1-5' do
  system('rake alert:campaign:week')
end

scheduler.every '1m' do
  Mailer.job_scheduller.deliver
end