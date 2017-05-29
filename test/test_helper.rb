# frozen_string_literal: true

require "simplecov"
SimpleCov.start "rails"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/pride"
require "mocha/mini_test"
require "vcr"
require "webmock/minitest"

VCR.configure do |c|
  c.cassette_library_dir = "test/vcr_cassettes"
  c.hook_into :webmock
end


class ActiveSupport::TestCase
  fixtures :all
end
