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

  after_create :create_stripe_customer

  has_many :addresses
  has_many :credit_cards
  has_many :orders
  has_one  :subscription

  def stripe_customer
    @stripe_customer ||= Stripe::Customer.retrieve(stripe_customer_token)
  end

  def create_stripe_customer
    customer = Stripe::Customer.create(email: email)
    self.stripe_customer_token = customer.id
    save
  end
end
