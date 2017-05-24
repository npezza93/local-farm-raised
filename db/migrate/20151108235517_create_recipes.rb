# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[4.2]
  def change
    create_table :recipes do |t|

      t.timestamps null: false
    end
  end
end
