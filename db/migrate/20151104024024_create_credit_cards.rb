class CreateCreditCards < ActiveRecord::Migration[4.2]
  def change
    create_table :credit_cards do |t|
      t.references :user, index: true
      t.string :stripe_card_token

      t.timestamps null: false
    end
  end
end
