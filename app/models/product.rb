# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  image       :string
#  description :text
#  price       :decimal(8, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :title, :description, :image, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true

  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_items

  private

  def ensure_not_referenced_by_any_line_items
    return true if line_items.empty?

    errors.add(:base, "Line Items present")
    false
  end
end
