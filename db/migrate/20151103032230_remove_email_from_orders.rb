# frozen_string_literal: true

class RemoveEmailFromOrders < ActiveRecord::Migration[4.2]
  def change
    remove_column :orders, :email, :string
  end
end
