class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_address1
      t.string :street_address2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :phone_number
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
