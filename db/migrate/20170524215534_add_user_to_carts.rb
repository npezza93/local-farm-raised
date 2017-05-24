# frozen_string_literal: true

class AddUserToCarts < ActiveRecord::Migration[5.1]
  def change
    add_reference :carts, :user
  end
end
