# frozen_string_literal: true

class AddPolymorphicAssociationToPosts < ActiveRecord::Migration[4.2]
  def change
    add_reference :posts, :postable, polymorphic: true, index: true
  end
end
