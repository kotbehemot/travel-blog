require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kernel
  def gem_with_pg_fix(dep, *reqs)
    if dep == "pg" && reqs == ["~> 0.21"]
      reqs = ["~> 1.0"]
    end
    gem_without_pg_fix(dep, *reqs)
  end

  alias_method_chain :gem, :pg_fix
end
# pg 1.0 gem has removed these constants, but 4.2 ActiveRecord still expects them
PGconn   = PG::Connection
PGresult = PG::Result
PGError  = PG::Error

module TravelBlog
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.autoload_paths += %W(#{config.root}/lib)

    config.app_generators.scaffold_controller :responders_controller

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.available_locales = [:pl, :en]
    config.i18n.default_locale = :pl
    config.i18n.fallbacks = true
  end
end
