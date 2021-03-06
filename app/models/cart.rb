# frozen_string_literal: true

# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  session_id :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy, as: :orderable

  def self.find_or_create_by_session(session)
    find_by(session_id: session.id, id: session[:cart_id]) ||
      create(session_id: session.id)
  end

  def add_product(product_id)
    line_item_scope = line_items.where(product_id: product_id)

    if line_item_scope.empty?
      line_item_scope.create
    else
      line_item_scope.first.update(quantity: line_item_scope.first.quantity + 1)
      line_item_scope.first
    end
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end

  def count_items
    line_items.to_a.sum(&:quantity).to_s
  end

  def as_json
    line_items.map do |line_item|
      {
        type: :sku,
        parent: line_item.product.sku_id,
        quantity: line_item.quantity
      }
    end
  end

  def move_to_order(order)
    line_items.update_all(orderable_type: "Order", orderable_id: order.id)
    reload.destroy
  end
end
