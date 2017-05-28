# frozen_string_literal: true

# == Schema Information
#
# Table name: line_items
#
#  id             :integer          not null, primary key
#  quantity       :integer          default(1)
#  product_id     :integer
#  orderable_type :string
#  orderable_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require "test_helper"

class LineItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
