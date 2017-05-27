# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :trackable, :validatable, :rememberable

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
