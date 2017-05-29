# frozen_string_literal: true

require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  test "should show cart" do
    get cart_path
    assert_response :success
  end
end
