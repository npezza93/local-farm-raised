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

  def paid?
    status == "paid"
  end

  def fulfilled?
    status == "fulfilled"
  end

  def created?
    status == "created"
  end

  def save_with_payment(cart)
    return false if invalid?

    save_to_stripe do
      credit_card.set_as_default
      self.order_id  = (@order = generate_order(cart)).id
      self.charge_id = @order.pay(customer: user.customer_id).charge
      self.status    = :paid
      save
      cart.move_to_order(self)
    end
  end

  def fulfill(params)
    return false if refund.present?

    save_to_stripe do
      self.attributes = params.merge(status: :fulfilled)
      order.shipping.carrier         = shipping_carrier
      order.shipping.tracking_number = shipping_tracking_number
      order.status                   = "fulfilled"
      order.save
      save
    end
  end

  def cancel_order
    return false unless paid?

    save_to_stripe do
      self.refund_id = order.return_order({}).refund
      self.status = "cancelled"
      save
    end
  end

  def order
    return if order_id.blank?

    @order ||= Stripe::Order.retrieve(order_id)
  end

  def charge
    return if charge_id.blank?

    @charge ||= Stripe::Charge.retrieve(charge_id)
  end

  def refund
    return if refund_id.blank?

    @refund ||= Stripe::Refund.retrieve(refund_id)
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
