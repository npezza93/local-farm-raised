# frozen_string_literal: true

class AddCreditCardCacheColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :credit_cards, :last4, :string
    add_column :credit_cards, :exp_month, :integer
    add_column :credit_cards, :exp_year, :integer
    add_column :credit_cards, :brand, :string
  end
end
