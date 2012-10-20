#encoding: utf-8

#Dir["#{Rails.root}/db/seeds/*.rb"].each{ |file| require file }

require "#{Rails.root}/db/seeds/blood"
require "#{Rails.root}/db/seeds/person"
require "#{Rails.root}/db/seeds/company"
require "#{Rails.root}/db/seeds/notification"
require "#{Rails.root}/db/seeds/campaign"