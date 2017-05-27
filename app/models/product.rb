# frozen_string_literal: true
# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  price       :decimal(8, 2)
#  created_at  :datetime
#  updated_at  :datetime
#  image       :string
#


class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :title, :description, :image, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true

  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_items

  def self.search(search)
    if search.present?
      where("title LIKE ?", "%#{search}%")
    else
      all
    end
  end

  private

  def ensure_not_referenced_by_any_line_items
    return true if line_items.empty?

    errors.add(:base, "Line Items present")
    false
  end
end
