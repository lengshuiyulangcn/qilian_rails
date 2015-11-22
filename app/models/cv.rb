class Cv < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :experiences
end
