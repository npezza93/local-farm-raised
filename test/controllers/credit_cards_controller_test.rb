# frozen_string_literal: true

require "test_helper"

VCR.configure do |c|
  c.cassette_library_dir = "test/vcr_cassettes"
  c.hook_into :webmock
end

class CreditCardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get credit_cards_path

    assert_response :success
  end

  test "should get new" do
    get new_credit_card_path

    assert_response :success
  end

  # test "should create credit_card" do
  #   assert_difference("CreditCard.count") do
  #     post :create, credit_card: { stripe_card_token:
  #  @credit_card.stripe_customer_card_token, user_id: @credit_card.user_id,
  # last4: @credit_card.last4, brand: @credit_card.brand,
  # exp_month: @credit_card.exp_month, exp_year: @credit_card.exp_year }
  #   end
  #
  #   assert_redirected_to credit_card_path(assigns(:credit_card))
  # end

  test "should destroy credit_card" do
    assert_difference("CreditCard.count", -1) do
      VCR.use_cassette "delete_credit_card" do
        delete credit_card_path(credit_cards(:deleted_card))
      end
    end

    assert_redirected_to credit_cards_path
  end
end
