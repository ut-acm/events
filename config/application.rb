require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Acm
  class Application < Rails::Application
  	config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
	config.assets.precompile += Ckeditor.assets
	config.assets.precompile += %w(ckeditor/*)
    config.time_zone = 'Tehran'
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.assets.paths << "#{Rails.root}"
  end
end
