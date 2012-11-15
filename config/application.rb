# encoding: utf-8
require File.expand_path('../boot', __FILE__)
# #require 'action_controller/railtie'
# #require 'action_mailer/railtie'
# #require 'active_resource/railtie'
# #require 'sprockets/railtie'
# #require 'rails/test_unit/railtie'
# require 'rails/all'
# require 'omniauth'
# Bundler.require(:default, :assets, Rails.env) if defined?(Bundler)
# #Bundler.require(*Rails.groups(:assets => %w(development test))) if defined?(Bundler)

require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'active_resource/railtie'
require 'sprockets/railtie'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Doandose
  class Application < Rails::Application
    config.time_zone = 'Brasilia'
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml').to_s]
    Dir["#{config.root}/lib/**/*.rb"].each{ |file| require file }
    config.i18n.default_locale = :'pt-BR'
    config.filter_parameters += [:password]
    config.assets.enabled = true
    config.assets.version = '1.0'
    config.assets.precompile += %w( admin.js admin.css institution.js institution.css mailer.css print.css iframe.css)
    config.action_mailer.default_url_options = { host: 'doandodev.se', port: nil, trailing_slash: true }
    initializer :add_fonts, :group => :all, :after => :append_assets_path do
       config.assets.paths.unshift Rails.root.join('vendor', 'fonts').to_s
    end
    initializer :add_jquery_fancybox, :group => :all, :after => :append_assets_path do
       config.assets.paths.unshift Rails.root.join('vendor', 'assets', 'images', 'jquery_fancybox').to_s
    end
  end
end
