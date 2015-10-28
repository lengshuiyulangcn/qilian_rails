class Job < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end
