#encoding: utf-8

Dir["#{Rails.root}/db/seeds/*.rb"].each{ |file| require file }