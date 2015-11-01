class Job < ActiveRecord::Base
  has_and_belongs_to_many :labels
  mount_uploader :image, ImageUploader
  self.per_page = 10 
  def self.category_select(labels,c)
    category_labels = labels.select{|id| Label.find(id).category == c}
    return self.all if category_labels == []
    self.includes(:labels).where(labels: {id: category_labels})
  end

  def self.full_calendar_event
    Job.all.map{|job| {id: job.id, title: "〆切:"+job.title, start: job.expire_at.to_date, color: "red", url: "/job/#{job.id}"}} 
  end

end
