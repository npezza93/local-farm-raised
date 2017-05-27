# frozen_string_literal: true

class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.string :session_id, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
