# frozen_string_literal: true

# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  session_id :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
