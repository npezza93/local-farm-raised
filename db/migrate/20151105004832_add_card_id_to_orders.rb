class AddCardIdToOrders < ActiveRecord::Migration[4.2]
  def change
    add_reference :orders, :credit_card, index: true
  end
end
