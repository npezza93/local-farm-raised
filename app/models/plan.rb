class Plan
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :amount, :name, :id

  validates :amount, :name, :id, presence: true
  validates :amount, numericality: {greater_than_or_equal_to: 0}

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def save_plan
    Stripe::Plan.create(
      :amount => (amount).to_i,
      :interval => "month",
      :interval_count => 1,
      :name => name,
      :currency => "usd",
      :id => id
    )
  end
end
