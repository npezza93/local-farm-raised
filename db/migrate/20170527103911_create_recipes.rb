# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :content

      t.timestamps null: false
    end
  end
end
