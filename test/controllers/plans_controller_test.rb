# frozen_string_literal: true

require "test_helper"

class PlansControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
  end

  test "should get index" do
    VCR.use_cassette("plans_path") do
      get plans_path
    end

    assert_response :success
  end

  test "should get new" do
    get new_plan_path

    assert_response :success
  end

  test "should create plan" do
    VCR.use_cassette("create_plan") do
      assert_difference "Plan.all.count" do
        post plans_path, params: {
          plan: { id: :blue, name: "Blue", amount: 100 }
        }
      end
    end

    assert_redirected_to plans_path
  end

  test "should render new if validation fails" do
    post plans_path, params: {
      plan: { id: :blue, amount: 100 }
    }

    assert_response :success
  end

  test "should destroy plan" do
    VCR.use_cassette("destroy_plan") do
      assert_difference "Plan.all.count", -1 do
        delete plan_path(:blue)
      end
    end

    assert_redirected_to plans_path
  end

  test "should not have access as regular user" do
    sign_out users(:admin)

    get plans_path
    assert_redirected_to store_path
    get new_plan_path
    assert_redirected_to store_path
    post plans_path
    assert_redirected_to store_path
    delete plan_path(:blue)
    assert_redirected_to store_path
  end
end
