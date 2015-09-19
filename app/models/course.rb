class Course < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :schedules
end
