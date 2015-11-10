class RemovePostableIdAndPostableTypeFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :postable_id, :integer
    remove_column :posts, :postable_type, :string
  end
end
