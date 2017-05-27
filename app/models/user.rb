# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean          default(FALSE)
#  stripe_customer_token  :string
#  name                   :string
#

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
