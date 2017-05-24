# frozen_string_literal: true

class AddStripeCardToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :stripe_card_token, :string
  end
end
