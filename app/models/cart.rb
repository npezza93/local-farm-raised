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
end
