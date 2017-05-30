# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                       :integer          not null, primary key
#  refund_id                :string
#  charge_id                :string
#  order_id                 :string
#  shipping_carrier         :string
#  shipping_tracking_number :string
#  status                   :string           default("created")
#  user_id                  :integer
#  credit_card_id           :integer
#  address_id               :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class Order < ApplicationRecord
  has_many :line_items, as: :orderable, dependent: :destroy
  belongs_to :address
  belongs_to :user
  belongs_to :credit_card

  def count_items
    line_items.to_a.sum(&:quantity).to_s
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end

  def save_with_payment(cart)
    return false if invalid?

    save_to_stripe do
      credit_card.set_as_default
      self.order_id  = (@order = generate_order(cart)).id
      self.charge_id = @order.pay(customer: user.customer_id).charge
      save
      cart.move_to_order(self)
    end
  end

  def cancel_order
    if valid?
      refund = Stripe::Refund.create(
        charge: stripe_charge_token, reason: :requested_by_customer
      )
      self.refund_token = refund.id
      self.refund = true
      save!
    end
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while refunding charge: #{e.message}"
      errors.add :base, "Charge has already been refunded."
      false
  end

  def order
    return if order_id.blank?

    @order ||= Stripe::Order.retrieve(order_id)
  end

  def charge
    return if charge_id.blank?

    @charge ||= Stripe::Charge.retrieve(charge_id)
  end

  private

  def generate_order(cart)
    return order if order.present?

    Stripe::Order.create(
      currency: :usd,
      items: cart.as_json,
      shipping: address.as_json,
      email: user.email
    )
  end
end
