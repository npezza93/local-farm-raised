# frozen_string_literal: true

class RemovePostableIdAndPostableTypeFromPosts < ActiveRecord::Migration[4.2]
  def change
    remove_column :posts, :postable_id, :integer
    remove_column :posts, :postable_type, :string
  end
end
