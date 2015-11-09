class Blog < ActiveRecord::Base
  has_one :post, as: :postable

  accepts_nested_attributes_for :post

  def self.search(search)
    if search && search != ""
      joins(:post).where("posts.title LIKE ?", "%#{search}%")
    else
      all
    end
  end
end
