# frozen_string_literal: true

require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should edit user fields" do
    put user_registration_path, params: { user: { email: "hi@email.com" } }

    assert_equal @user.reload.email, "hi@email.com"
    assert_redirected_to root_url
  end

  test "should sign up user with a new account" do
    sign_out @user
    assert_difference "User.count" do
      VCR.use_cassette "create_customer_after_signup" do
        post user_registration_path, params: { user: {
          name: "name",
          email: "hello@email.com",
          password: (password = SecureRandom.hex),
          password_confirmation: password
        } }
      end
    end

    assert_redirected_to root_url
  end
end
