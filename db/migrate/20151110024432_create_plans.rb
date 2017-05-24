# frozen_string_literal: true

class CreatePlans < ActiveRecord::Migration[4.2]
  def change
    create_table :plans do |t|
      t.timestamps null: false
    end
  end
end
