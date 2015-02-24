require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module It61Rails
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Moscow'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.available_locales = [:ru]
    config.i18n.default_locale = :ru

    config.assets.precompile += %w(editor.js)
    config.responders.flash_keys = [:success, :error]

    config.eager_load_paths += ["#{config.root}/lib/it61"]

    config.action_mailer.default_url_options =  { host: ENV['APP_HOST'] }
    config.action_mailer.default_options = {
      from: ENV['MAILER_FROM'],
      reply_to: ENV['MAILER_RETURN_PATH']
    }
  end
end
