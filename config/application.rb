require_relative 'boot'

require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

if File.exist?(File.expand_path('../mail_config.json', __FILE__))
	CONFIG = JSON.parse(File.read(File.expand_path('../mail_config.json', __FILE__)))
	CONFIG.merge! CONFIG.fetch(Rails.env, {})
	CONFIG.symbolize_keys!
end

module Torser
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
