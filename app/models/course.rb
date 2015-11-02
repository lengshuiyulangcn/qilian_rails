class Course < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :schedules
  has_and_belongs_to_many :users, join_table: "users_courses"
  has_many :entries
 
  def self.full_calendar_event
    Course.all.map{|course| {id: course.id, title: course.name, start: course.starttime, end: course.endtime, color: 'green'}} 
  end
end
