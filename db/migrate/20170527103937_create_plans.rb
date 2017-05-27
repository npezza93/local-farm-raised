# frozen_string_literal: true

class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
