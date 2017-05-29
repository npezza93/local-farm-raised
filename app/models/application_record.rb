# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def save_to_stripe
    self.class.transaction do
      yield
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error: #{e.message}"
    errors.add :base, "Stripe error while saving: #{e.message}"
    false
  end
end
