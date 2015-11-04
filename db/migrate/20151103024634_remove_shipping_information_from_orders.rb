class RemoveShippingInformationFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :first_name, :string
    remove_column :orders, :last_name, :string
    remove_column :orders, :street_address1, :string
    remove_column :orders, :street_address2, :string
    remove_column :orders, :city, :string
    remove_column :orders, :zipcode, :string
    remove_column :orders, :state, :string
    remove_column :orders, :phone_number, :string
  end
end
