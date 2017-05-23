class AddNameAndAmountToPlans < ActiveRecord::Migration[4.2]
  def change
    add_column :plans, :name, :string
    add_column :plans, :amount, :decimal
  end
end
