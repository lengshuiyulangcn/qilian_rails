class Course < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :schedules
  has_and_belongs_to_many :users, join_table: "users_courses"
end
