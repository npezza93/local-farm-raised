# frozen_string_literal: true

class AddRefundToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :refund, :boolean, default: false
  end
end
