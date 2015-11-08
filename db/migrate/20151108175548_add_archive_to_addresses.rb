class AddArchiveToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :archived, :boolean, default: false
  end
end
