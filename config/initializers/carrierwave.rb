# frozen_string_literal: true

CarrierWave.configure do |config|
  config.asset_host = Rails.application.default_url_options[:host]
end
