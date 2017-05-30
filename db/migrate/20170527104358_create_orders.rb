# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      string_fields.each { |field| t.string field }
      t.string :status, default: :created
      references.each do |reference|
        t.references reference, index: true
      end

      t.timestamps null: false
    end
  end

  private

  def string_fields
    %i(refund_id charge_id order_id shipping_carrier shipping_tracking_number)
  end

  def references
    %i(user credit_card address)
  end
end
