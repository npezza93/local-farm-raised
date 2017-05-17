class Post < ApplicationRecord
  validates_presence_of :title, :content

  def self.search(search)
    if search && search != ""
      where("title LIKE ? or content LIKE ?", "%#{search}%", "%#{search}%")
    else
      all
    end
  end
end
