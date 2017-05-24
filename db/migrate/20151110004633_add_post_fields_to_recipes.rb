# frozen_string_literal: true

class AddPostFieldsToRecipes < ActiveRecord::Migration[4.2]
  def change
    add_column :recipes, :title, :string
    add_column :recipes, :content, :text
  end
end
