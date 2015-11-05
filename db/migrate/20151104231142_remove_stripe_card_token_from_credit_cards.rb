class RemoveStripeCardTokenFromCreditCards < ActiveRecord::Migration
  def change
    remove_column :credit_cards, :stripe_card_token, :string
  end
end
