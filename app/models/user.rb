class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :create_stripe_customer

  has_many :addresses
  has_many :credit_cards
  has_many :orders
  has_one  :subscription

  def create_stripe_customer
    customer = Stripe::Customer.create(email: email)
    self.stripe_customer_token = customer.id
    save!
  end
end
