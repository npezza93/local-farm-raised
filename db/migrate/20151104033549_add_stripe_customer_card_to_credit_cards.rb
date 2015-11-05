class AddStripeCustomerCardToCreditCards < ActiveRecord::Migration
  def change
    add_column :credit_cards, :stripe_customer_card_token, :string
  end
end
