# frozen_string_literal: true
# == Schema Information
#
# Table name: credit_cards
#
#  id                         :integer          not null, primary key
#  user_id                    :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  stripe_customer_card_token :string
#  last4                      :string
#  exp_month                  :integer
#  exp_year                   :integer
#  brand                      :string
#


require "test_helper"

class CreditCardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
