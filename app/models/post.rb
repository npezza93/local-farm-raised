# frozen_string_literal: true
# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class Post < ApplicationRecord
  validates :title, :content, presence: true

  def self.search(search)
    return all if search.blank?

    where("title LIKE ? or content LIKE ?", "%#{search}%", "%#{search}%")
  end
end
