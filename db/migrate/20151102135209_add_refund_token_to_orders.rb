class AddRefundTokenToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :refund_token, :string
  end
end
