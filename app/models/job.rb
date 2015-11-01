class Job < ActiveRecord::Base
  has_and_belongs_to_many :labels
  mount_uploader :image, ImageUploader
  self.per_page = 10 
  def self.category_select(labels,c)
    category_labels = labels.select{|id| Label.find(id).category == c}
    return self.all if category_labels == []
    self.includes(:labels).where(labels: {id: category_labels})
  end
end
