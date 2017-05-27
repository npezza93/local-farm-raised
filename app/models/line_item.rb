# frozen_string_literal: true

# == Schema Information
#
# Table name: line_items
#
#  id         :integer          not null, primary key
#  product_id :integer
#  cart_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  quantity   :integer          default(1)
#  order_id   :integer
#

class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  def total_price
    product.price * quantity
  end
end
