class RemoveLast4AndBrandAndExpMonthAndExpYearFromCreditCards < ActiveRecord::Migration
  def change
    remove_column :credit_cards, :brand, :string
    remove_column :credit_cards, :last4, :string
    remove_column :credit_cards, :exp_month, :string
    remove_column :credit_cards, :exp_year, :string
  end
end