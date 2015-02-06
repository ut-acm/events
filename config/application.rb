require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Acm
  class Application < Rails::Application
    config.time_zone = 'Tehran'
    config.assets.precompile += Ckeditor.assets
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
  end
end
