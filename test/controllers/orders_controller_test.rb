# frozen_string_literal: true

require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  test "should get index" do
    get orders_path

    assert_response :success
  end

  test "a user must be signed in to see orders" do
    sign_out users(:one)
    get orders_path

    assert_redirected_to store_path
  end

  test "should get new" do
    Cart.stubs(find_or_create_by_session: carts(:one))

    get new_order_path

    assert_response :success
  end

  test "redirected to store if the cart is empty" do
    get new_order_path

    assert_redirected_to store_url
  end

  test "should create order" do
    Cart.stubs(find_or_create_by_session: carts(:one))

    VCR.use_cassette("charge") do
      assert_difference("Order.count") do
        assert_difference("Cart.count", -1) do
          post orders_path, params: { order: {
            address_id: addresses(:one).id,
            credit_card_id: credit_cards(:one).id
          } }
        end
      end
    end

    assert_redirected_to store_path
  end

  test "should show order" do
    get order_path(orders(:one))

    assert_response :success
  end

  # test "should destroy order" do
  #   assert_difference("Order.count", -1) do
  #     delete :destroy, id: @order
  #   end
  #
  #   assert_redirected_to orders_path
  # end
end
