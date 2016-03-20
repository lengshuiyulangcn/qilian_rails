class Post < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :marked_posts
  has_many :liked_users,  through: :marked_posts, source: :user
  mount_uploader :image, ImageUploader
  is_impressionable  counter_cache:  true, column_name: :view_count
  self.per_page = 5
  def self.most_viewed(top=5)
    Post.order("view_count DESC").first(5)
  end
  def truncate_description(length=200)
    ActionController::Base.helpers.truncate(
     ActionController::Base.helpers.strip_tags(ApplicationController.helpers.markdown(self.content)), 
      length: length)
  end

  def markdown
    ApplicationController.helpers.markdown(self.content)
  end
end
