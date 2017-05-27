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


require "test_helper"

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
