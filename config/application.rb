require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Givepuppies
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.assets.precompile += %w( bookmarklet/bookmarklet.js )

    Givepuppies::Application.config.secret_key_base = '29dfd090da9aad06e2ecc0218c125af4f58bdf0050784cedf9c6c525c01f7b32c8d1b3802e18ec20a2d17b246f4d2856fce7fb6a0e0cccf7d4d8ecdeb7eab3f6'
    Givepuppies::Application.config.i18n.enforce_available_locales = true
  end
end
