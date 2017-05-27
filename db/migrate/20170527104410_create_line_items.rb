# frozen_string_literal: true

class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.integer :quantity, default: 1
      t.references :product, index: true
      t.references :cart, index: true
      t.references :order, index: true

      t.timestamps null: false
    end
  end
end
