# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  image       :string
#  description :text
#  product_id  :string
#  sku_id      :string
#  price       :decimal(8, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
  include Rails.application.routes.url_helpers

  mount_uploader :image, ImageUploader
  validates :title, :description, :image, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true

  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_items

  after_create :generate_stripe_ids

  def sku
    @sku ||= Stripe::SKU.retrieve(sku_id)
  end

  def product
    @product ||= Stripe::Product.retrieve(product_id)
  end

  private

  def ensure_not_referenced_by_any_line_items
    return true if line_items.empty?

    errors.add(:base, "Line Items present")
    false
  end

  def generate_stripe_ids
    save_to_stripe do
      self.product_id = generate_product_id
      self.sku_id = generate_sku_id
      save
    end
  end

  def generate_product_id
    Stripe::Product.create(
      name: title, description: description, url: product_url(self),
      images: [image_url]
    ).id
  end

  def generate_sku_id
    Stripe::SKU.create(
      product: product_id, price: (price * 100).to_i, currency: :usd,
      inventory: { type: :infinite }
    ).id
  end
end
