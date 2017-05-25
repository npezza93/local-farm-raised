# frozen_string_literal: true

class Address < ApplicationRecord
  default_scope { where(archived: false) }

  US_STATES =
    %w(AL AK AZ AR CA CO CT DE DC FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN
       MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA PR RI SC SD TN TX UT VT VA
       WA WV WI WY).freeze

  belongs_to :user
  has_many :orders

  validates :first_name, :last_name, :street_address1, :city, :zipcode,
            presence: true
  validates :state, inclusion: { in: US_STATES }

  def name
    first_name + " " + last_name
  end

  def archive!
    self.archived = true
    save!
  end
end
