class RemoveStripeFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :stripe_charge_token, :string
    remove_column :orders, :stripe_card_token, :string
  end
end
