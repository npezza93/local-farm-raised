# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  reset_password_token   :string
#  customer_id            :string
#  name                   :string
#  email                  :string
#  encrypted_password     :string
#  admin                  :boolean          default(FALSE)
#  reset_password_sent_at :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  has_many :addresses
  has_many :credit_cards
  has_many :orders
  has_one  :subscription

  after_create :generate_customer_id

  def customer
    return if customer_id.blank?

    @customer ||= Stripe::Customer.retrieve(customer_id)
  end

  private

  def generate_customer_id
    return customer.id if customer.present?

    save_to_stripe do
      self.customer_id =
        Stripe::Customer.create(email: email, description: name).id
      save
    end
  end
end
