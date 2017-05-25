# frozen_string_literal: true

require "test_helper"

class AddressesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @address = addresses(:one)
  end

  test "should get index" do
    get addresses_path

    assert_response :success
  end

  test "should get new" do
    get new_address_path

    assert_response :success
  end

  test "should create address" do
    assert_difference("Address.count") do
      post addresses_path, params: {
        address: {
          city: @address.city, first_name: @address.first_name,
          last_name: @address.last_name, phone_number: @address.phone_number,
          state: @address.state, street_address1: @address.street_address1,
          zipcode: @address.zipcode
        }
      }
    end

    assert_redirected_to addresses_path
  end

  test "should get edit" do
    get edit_address_path(@address)

    assert_response :success
  end

  test "should update address" do
    patch address_path(@address), params: {
      address: {
        city: @address.city, first_name: @address.first_name,
        last_name: @address.last_name, phone_number: @address.phone_number,
        state: @address.state, street_address1: @address.street_address1,
        zipcode: @address.zipcode
      }
    }

    assert_redirected_to addresses_path
  end

  test "should destroy address" do
    assert_difference("Address.count", -1) do
      delete address_path(@address)
    end

    assert_redirected_to addresses_path
  end
end
