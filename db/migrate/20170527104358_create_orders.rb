# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      %i(refund_token charge_id order_id).each do |field|
        t.string field
      end
      t.boolean :refund, default: false
      t.references :user, index: true
      t.references :credit_card, index: true
      t.references :address, index: true

      t.timestamps null: false
    end
  end
end
