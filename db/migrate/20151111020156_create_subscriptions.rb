# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[4.2]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :plan, index: true

      t.timestamps null: false
    end
  end
end
