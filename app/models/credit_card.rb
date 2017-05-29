# frozen_string_literal: true

# == Schema Information
#
# Table name: credit_cards
#
#  id                         :integer          not null, primary key
#  user_id                    :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  stripe_customer_card_token :string
#  last4                      :string
#  exp_month                  :integer
#  exp_year                   :integer
#  brand                      :string
#

class CreditCard < ApplicationRecord
  GRADIENTS = {
    visa: "linear-gradient(120deg, #e0c3fc 0%, #8ec5fc 100%);",
    mastercard: "linear-gradient(to right, #92fe9d 0%, #00c9ff 100%);",
    discover: "linear-gradient(to top, #f77062 0%, #fe5196 100%);",
    "american-express" => "linear-gradient(-225deg, #20E2D7 0%, #F9FEA5 100%);",
    "diners-club" => "linear-gradient(to right, #fa709a 0%, #fee140 100%);",
    jcb: "linear-gradient(45deg, #ff9a9e 0%, #fad0c4 99%, #fad0c4 100%);"
  }.with_indifferent_access.freeze

  belongs_to :user
  has_many :orders

  def save_card(stripe_card_token)
    return unless valid?

    save_to_stripe(stripe_card_token) do |card|
      self.stripe_customer_card_token = card.id
      self.last4 = card.last4
      self.exp_month = card.exp_month
      self.exp_year = card.exp_year
      self.brand = card.brand
      save
    end
  end

  def destroy
    user.stripe_customer.sources.retrieve(stripe_customer_card_token).delete
    super
  end

  def gradient
    self.class::GRADIENTS[brand.parameterize]
  end

  def set_as_default
    user.stripe_customer.default_source = stripe_customer_card_token
    user.stripe_customer
  end

  private

  def save_to_stripe(stripe_card_token)
    customer = Stripe::Customer.retrieve(user.stripe_customer_token)
    card     = customer.sources.create(source: stripe_card_token)
    yield(card)
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating card: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
