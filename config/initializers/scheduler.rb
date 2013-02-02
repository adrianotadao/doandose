require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

scheduler.every '1h' do
  system('rake alert:campaign:hour')
  system('rake alert:notification:email_to_canceleds')
  Mailer.job_scheduller('campanhas por horas e notificacoes canceladas').deliver
end

scheduler.cron '0 05 * * 1-5' do
  system('rake alert:campaign:day')
  Mailer.job_scheduller('verifica as campanhas as 5').deliver
end

scheduler.cron '0 23 * * 1-5' do
  system('rake alert:campaign:week')
  Mailer.job_scheduller('verifica as campanhas as 23').deliver
end