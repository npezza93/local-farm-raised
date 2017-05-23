class RemoveStripeCardTokenFromCreditCards < ActiveRecord::Migration[4.2]
  def change
    remove_column :credit_cards, :stripe_card_token, :string
  end
end
