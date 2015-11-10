class CreditCard < ActiveRecord::Base
  belongs_to :user
  has_many :orders

  def save_card(stripe_card_token)
    if valid?
      customer = Stripe::Customer.retrieve(user.stripe_customer_token)
      card     = customer.sources.create(:source => stripe_card_token)
      self.stripe_customer_card_token = card.id
      self.last4 = card.last4
      self.exp_month = card.exp_month
      self.exp_year = card.exp_year
      self.brand = card.brand
      save!
    end
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating card: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
  end

  def destroy_card
    customer = Stripe::Customer.retrieve(user.stripe_customer_token)
    customer.sources.retrieve(stripe_customer_card_token).delete()
    self.destroy!
  end

  def self.icon(brand)
    icon = brand.downcase.strip.tr(" ", "-")
    icon == "american-express" ? "amex" : icon
  end
end
