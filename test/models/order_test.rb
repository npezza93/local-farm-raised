# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                       :integer          not null, primary key
#  refund_id                :string
#  charge_id                :string
#  order_id                 :string
#  shipping_carrier         :string
#  shipping_tracking_number :string
#  status                   :string           default("created")
#  user_id                  :integer
#  credit_card_id           :integer
#  address_id               :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
