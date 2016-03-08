class MypageController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @cv = @user.cv
    @experiences = @cv.experiences.order(:time_from)
  end
  def my_courses
    @courses = Course.find(current_user.entries.map{|entry| entry.course_id })
  end
  def cv
    @user = current_user
    @cv = @user.cv
    @experiences = @cv.experiences.order(:time_from)
  end

end
