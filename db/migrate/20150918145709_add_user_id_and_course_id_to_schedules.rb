class AddUserIdAndCourseIdToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :user_id, :integer
    add_column :schedules, :course_id, :integer
  end
end
