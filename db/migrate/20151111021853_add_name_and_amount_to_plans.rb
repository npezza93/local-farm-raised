class AddNameAndAmountToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :name, :string
    add_column :plans, :amount, :decimal
  end
end
