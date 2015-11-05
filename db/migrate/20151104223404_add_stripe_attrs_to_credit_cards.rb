class AddStripeAttrsToCreditCards < ActiveRecord::Migration
  def change
    add_column :credit_cards, :last4, :string
    add_column :credit_cards, :brand, :string
    add_column :credit_cards, :exp_month, :string
    add_column :credit_cards, :exp_year, :string
  end
end
