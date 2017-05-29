# frozen_string_literal: true

require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @product = products(:one)
    @params = {
      title: Faker::Food.ingredient,
      price: (1..50).to_a.sample,
      description: Faker::Lorem.paragraphs(6).join,
      remote_image_url: Faker::LoremPixel.image
    }
  end

  test "should get index" do
    get store_path

    assert_response :success
  end

  test "should get new" do
    get new_product_path

    assert_response :success
  end

  test "should create product" do
    VCR.turn_off!
    WebMock.allow_net_connect!

    assert_difference("Product.count") do
      post products_path, params: {
        product: @params.merge(title: SecureRandom.hex)
      }
    end

    assert_redirected_to product_path(Product.order(created_at: :asc).last)

    VCR.turn_on!
    WebMock.disable_net_connect!
  end

  test "should show product" do
    get product_path(@product)

    assert_response :success
  end

  test "should get edit" do
    get edit_product_path(@product)

    assert_response :success
  end

  test "should update product" do
    VCR.turn_off!
    WebMock.allow_net_connect!

    patch product_path(@product), params: { product: @params }

    assert_redirected_to product_path(@product)

    VCR.turn_on!
    WebMock.disable_net_connect!
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_path(@product)
    end

    assert_redirected_to store_path
  end

  test "only admins can edit products" do
    sign_out users(:admin)
    sign_in users(:one)

    get edit_product_path(@product)
    assert_redirected_to store_path
  end
end
