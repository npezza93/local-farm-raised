class Post < ActiveRecord::Base
  belongs_to :postable, polymorphic: true

  validates_presence_of :title, :content
end
