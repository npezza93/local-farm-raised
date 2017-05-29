# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  street_address1 :string
#  street_address2 :string
#  city            :string
#  state           :string
#  zipcode         :string
#  phone_number    :string
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  archived        :boolean          default(FALSE)
#

class Address < ApplicationRecord
  default_scope { where(archived: false) }

  US_STATES =
    %w(AL AK AZ AR CA CO CT DE DC FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN
       MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA PR RI SC SD TN TX UT VT VA
       WA WV WI WY).sort.freeze

  belongs_to :user
  has_many :orders

  validates :first_name, :last_name, :street_address1, :city, :zipcode,
            presence: true
  validates :state, inclusion: { in: US_STATES }

  def name
    "#{first_name} #{last_name}"
  end

  def archive
    self.archived = true
    save
  end

  def as_json
    {
      name: name,
      address: {
        line1: street_address1, line2: street_address2,
        city: city, state: state, postal_code: zipcode,
        country: "US",
      }
    }
  end
end
