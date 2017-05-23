class AddImageToProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :image, :string
  end
end
