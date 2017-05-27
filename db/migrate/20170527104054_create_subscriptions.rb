# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :plan, index: true

      t.timestamps null: false
    end
  end
end
