# frozen_string_literal: true

require "test_helper"

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

  test "should create credit_card" do
    VCR.use_cassette("create_credit_card") do
      assert_difference("CreditCard.count") do
        post credit_cards_path, params: {
          stripe_card_token: "tok_1AOfZJGUzBox4K0LnL3ffsBU"
        }
      end
    end

    assert_redirected_to credit_cards_path
  end

  test "should destroy credit_card" do
    assert_difference("CreditCard.count", -1) do
      VCR.use_cassette "delete_credit_card" do
        delete credit_card_path(credit_cards(:deleted_card))
      end
    end

    assert_redirected_to credit_cards_path
  end
end
