# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      %i(first_name last_name street_address1 street_address2 city state zipcode
         phone_number).each do |field|
           t.string field
         end

      t.boolean :archived, default: false
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
