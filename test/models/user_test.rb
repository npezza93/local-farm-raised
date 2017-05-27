# frozen_string_literal: true

require "test_helper"
require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "test/vcr_cassettes"
  c.hook_into :webmock
end

class UserTest < ActiveSupport::TestCase
  test "creates customer in stripe" do
    @user = users(:one)
    VCR.use_cassette "create_customer" do
      assert @user.create_stripe_customer
    end
  end
end
