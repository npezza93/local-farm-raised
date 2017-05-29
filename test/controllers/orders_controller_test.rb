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

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end
  #
  # test "should create order" do
  #   assert_difference("Order.count") do
  #     post :create, order: { city: @order.city, eamil: @order.eamil, first_name: @order.first_name, last_name: @order.last_name, phone_number: @order.phone_number, street_address1: @order.street_address1, street_address2: @order.street_address2, zipcode: @order.zipcode }
  #   end
  #
  #   assert_redirected_to order_path(assigns(:order))
  # end
  #
  # test "should show order" do
  #   get :show, id: @order
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get :edit, id: @order
  #   assert_response :success
  # end
  #
  # test "should update order" do
  #   patch :update, id: @order, order: { city: @order.city, eamil: @order.eamil, first_name: @order.first_name, last_name: @order.last_name, phone_number: @order.phone_number, street_address1: @order.street_address1, street_address2: @order.street_address2, zipcode: @order.zipcode }
  #   assert_redirected_to order_path(assigns(:order))
  # end
  #
  # test "should destroy order" do
  #   assert_difference("Order.count", -1) do
  #     delete :destroy, id: @order
  #   end
  #
  #   assert_redirected_to orders_path
  # end
end
