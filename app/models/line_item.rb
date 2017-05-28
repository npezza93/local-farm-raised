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

class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :orderable, polymorphic: true

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  def total_price
    product.price * quantity
  end
end
