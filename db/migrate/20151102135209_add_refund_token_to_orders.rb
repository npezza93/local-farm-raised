class AddRefundTokenToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :refund_token, :string
  end
end
