# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LocalFarmRaised
  class Application < Rails::Application
    config.active_record.time_zone_aware_types = %i(datetime time)
    config.time_zone = "Eastern Time (US & Canada)"
    config.active_record.default_timezone = :local
  end
end
