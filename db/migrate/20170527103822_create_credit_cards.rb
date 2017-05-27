# frozen_string_literal: true

class CreateCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :credit_cards do |t|
      t.references :user, index: true
      t.string :stripe_customer_card_token
      t.string :last4
      t.string :brand
      t.integer :exp_month
      t.integer :exp_year
      t.timestamps null: false
    end
  end
end
