# frozen_string_literal: true

class AddSessionIdToCarts < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :session_id, :string
  end
end
