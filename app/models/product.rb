class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  validates :title, :description, :image, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true

  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_items

  def self.search(search)
    if search && search != ""
      where("title LIKE ?", "%#{search}%")
    else
      all
    end
  end

  private
    def ensure_not_referenced_by_any_line_items
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end
