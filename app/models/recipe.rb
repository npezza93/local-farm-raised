# frozen_string_literal: true

# == Schema Information
#
# Table name: recipes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#  content    :text
#

class Recipe < ApplicationRecord
  validates :title, :content, presence: true
end
