# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/pride"
require "webmock/minitest"

class ActiveSupport::TestCase
  fixtures :all
end
