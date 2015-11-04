class AddRefundToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :refund, :boolean, default: false
  end
end
