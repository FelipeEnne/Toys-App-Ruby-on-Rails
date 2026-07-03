require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module ToyApp
  class Application < Rails::Application
    config.load_defaults 8.0
    config.autoload_lib(ignore: %w[assets tasks])

    if ENV["SECRET_KEY_BASE"].present?
      config.secret_key_base = ENV["SECRET_KEY_BASE"]
    end
  end
end
