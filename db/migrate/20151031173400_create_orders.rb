# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[4.2]
  def change
    create_table :orders do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :street_address1
      t.string :street_address2
      t.string :city
      t.string :zipcode
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
