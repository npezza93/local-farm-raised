class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :address
  belongs_to :user

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def count_items
    line_items.to_a.sum(&:quantity).to_s
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end

  def self.search(search)
    if search
      where("id LIKE ?", "%#{search}%")
    else
      all
    end
  end

  def save_with_payment
    if valid?
      charge = Stripe::Charge.create(amount: (total_price*100).to_i, description: user.email, currency: "usd", card: stripe_card_token)
      self.stripe_charge_token = charge.id
      save!
    end
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating charge: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
  end

  def cancel_order
    if valid?
      refund = Stripe::Refund.create(charge: stripe_charge_token, reason: :requested_by_customer)
      self.refund_token = refund.id
      self.refund = true
      save!
    end
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while refunding charge: #{e.message}"
      errors.add :base, "Charge has already been refunded."
      false
    end
end
