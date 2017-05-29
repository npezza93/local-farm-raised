# frozen_string_literal: true

require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
  end

  test "should get index" do
    get users_path

    assert_response :success
  end

  test "should grant admin access" do
    @user = users(:one)

    refute @user.admin?
    put user_path(@user)

    assert @user.reload.admin?
    assert_redirected_to users_path(anchor: @user.id)
  end
end
