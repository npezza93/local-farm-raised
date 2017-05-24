# frozen_string_literal: true

class AddStripeCustomerCardToCreditCards < ActiveRecord::Migration[4.2]
  def change
    add_column :credit_cards, :stripe_customer_card_token, :string
  end
end
