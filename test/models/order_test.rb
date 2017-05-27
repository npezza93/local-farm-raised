# frozen_string_literal: true
# == Schema Information
#
# Table name: orders
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  refund              :boolean          default(FALSE)
#  refund_token        :string
#  address_id          :integer
#  user_id             :integer
#  credit_card_id      :integer
#  stripe_charge_token :string
#


require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
