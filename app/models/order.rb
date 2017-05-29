# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  refund_token   :string
#  charge_id      :string
#  order_id       :string
#  refund         :boolean          default(FALSE)
#  user_id        :integer
#  credit_card_id :integer
#  address_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
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

    credit_card.set_as_default

    save_to_stripe(cart) do |charge|
      self.stripe_charge_token = charge.id
      save
      cart.line_items.update_all(orderable_type: "Order", orderable_id: id)
      cart.destroy
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

  private

  def save_to_stripe(cart)
    charge = Stripe::Charge.create(
      amount: ((cart.total_price * 1.06) * 100.0).to_i,
      currency: "usd",
      description: user.email, customer: user.stripe_customer_token
    )
    yield(charge)
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
