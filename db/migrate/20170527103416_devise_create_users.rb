# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table(:users) do |t|
      %i(reset_password_token stripe_customer_token name email
         encrypted_password).each do |field|
        t.string field
      end
      t.boolean :admin, default: false
      t.datetime :reset_password_sent_at
      t.timestamps null: false
    end

    add_indexes
  end

  private

  def add_indexes
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
