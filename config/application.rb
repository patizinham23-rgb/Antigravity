require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module AntigravityLms
  class Application < Rails::Application
    config.load_defaults 8.0
    config.autoload_lib(ignore: %w[assets tasks])

    config.time_zone = "Brasilia"
    config.i18n.default_locale = :"pt-BR"
    config.i18n.available_locales = [:"pt-BR", :en]

    config.generators do |g|
      g.test_framework :test_unit, fixture: true
      g.fixture_replacement :factory_bot, dir: "test/factories"
    end
  end
end
