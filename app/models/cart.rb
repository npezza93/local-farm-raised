# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def self.find_or_create_by_session(session)
    find_by(session_id: session.id, id: session[:cart_id]) ||
      create(session_id: session.id)
  end

  def add_product(product_id, quantity)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += quantity.to_i
    else
      current_item =
        line_items.build(product_id: product_id, quantity: quantity)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end

  def count_items
    line_items.to_a.sum(&:quantity).to_s
  end
end
