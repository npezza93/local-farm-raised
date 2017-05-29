# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.string :image
      t.text :description
      t.string :product_id
      t.string :sku_id
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
