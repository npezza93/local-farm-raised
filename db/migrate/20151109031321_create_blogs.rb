# frozen_string_literal: true

class CreateBlogs < ActiveRecord::Migration[4.2]
  def change
    create_table :blogs do |t|

      t.timestamps null: false
    end
  end
end
