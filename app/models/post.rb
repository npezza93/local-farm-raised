# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, :content, presence: true

  def self.search(search)
    return all if search.blank?

    where("title LIKE ? or content LIKE ?", "%#{search}%", "%#{search}%")
  end
end
