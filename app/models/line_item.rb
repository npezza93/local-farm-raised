# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  def total_price
    product.price * quantity
  end
end
