class Job < ActiveRecord::Base
  has_and_belongs_to_many :labels
  mount_uploader :image, ImageUploader
end
