# frozen_string_literal: true

require "test_helper"

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  test "should create line_item" do
    assert_difference("LineItem.count") do
      post line_items_path, params: {
        line_item: { product_id: products(:one).id }
      }
    end

    assert_redirected_to store_path
  end

  test "should update quantity if line_item exists" do
    Cart.stubs(find_or_create_by_session: carts(:one))
    @line_item = line_items(:one)

    assert_no_difference("LineItem.count") do
      post line_items_path, params: {
        line_item: { product_id: @line_item.product_id }
      }
    end

    assert_equal @line_item.reload.quantity, 2
    assert_redirected_to store_path
  end

  test "should update line_item quantity" do
    Cart.stubs(find_or_create_by_session: carts(:one))
    @line_item = line_items(:one)

    patch line_item_path(@line_item), params: {
      line_item: { quantity: 2 }, format: :js
    }

    assert_equal @line_item.reload.quantity, 2
    assert_response :success
  end

  test "should delete line_item if quantity is 0" do
    Cart.stubs(find_or_create_by_session: carts(:one))
    @line_item = line_items(:one)

    assert_difference("LineItem.count", -1) do
      patch line_item_path(@line_item), params: {
        line_item: { quantity: 0 }, format: :js
      }
    end

    assert_raises ActiveRecord::RecordNotFound do
      @line_item.reload
    end
    assert_response :success
  end
end
