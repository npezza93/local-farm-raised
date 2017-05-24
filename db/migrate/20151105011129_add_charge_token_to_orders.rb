# frozen_string_literal: true

class AddChargeTokenToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :stripe_charge_token, :string
  end
end
