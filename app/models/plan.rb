# frozen_string_literal: true

class Plan
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :amount, :name, :id

  validates :amount, :name, :id, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  def initialize(attributes = {})
    attributes.each do |name, value|
      next unless respond_to?("#{name}=")

      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  class << self
    def all
      Stripe::Plan.all.map do |plan|
        new(plan.as_json)
      end
    end

    def find(id)
      new(Stripe::Plan.retrieve(id).as_json)
    end
  end

  def save
    return false if invalid?

    Stripe::Plan.create(
      amount: amount.to_i, id: id, name: name,
      interval: "month", interval_count: 1, currency: "usd"
    )
  end

  def destroy
    Stripe::Plan.retrieve(id).delete
  end
end
