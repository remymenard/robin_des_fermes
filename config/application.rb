require_relative 'boot'

require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module RobinDesFermes
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
    I18n.config.enforce_available_locales = false
    I18n.config.available_locales = [:fr]
    I18n.default_locale = :fr
    Rack::Utils.multipart_part_limit = 0

    config.active_job.queue_adapter = :sidekiq
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
