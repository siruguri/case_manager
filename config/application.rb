require 'dotenv'
Dotenv.load

require File.expand_path('../boot', __FILE__)
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module CaseManager
  class NoTokenException < Exception
  end

  class Application < Rails::Application
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    config.active_record.raise_in_transactional_callbacks = true
    config.active_job.queue_adapter = :sidekiq
    config.middleware.insert(0, Rack::Deflater)
    config.autoload_paths += %W(#{config.root}/lib)

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # rails will fallback to config.i18n.default_locale translation
    config.i18n.fallbacks = true
    I18n.enforce_available_locales = false
    
    # rails will fallback to en, no matter what is set as config.i18n.default_locale
    # config.i18n.fallbacks = [:en]
  end
end
