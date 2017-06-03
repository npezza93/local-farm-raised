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

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "creates customer in stripe" do
    VCR.use_cassette "create_customer" do
      assert User.create(
        name: "name",
        email: "email",
        password: "password",
        password_confirmation: "password"
      )
    end
  end
end
