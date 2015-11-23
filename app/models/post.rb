class Post < ActiveRecord::Base
  has_and_belongs_to_many :categories
  mount_uploader :image, ImageUploader
  is_impressionable  counter_cache:  true, column_name: :view_count
  self.per_page = 5
  def self.most_viewed(top=5)
    Post.order("fakeview DESC").first(5)
  end
end
