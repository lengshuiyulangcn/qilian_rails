class MypageController < ApplicationController
  before_action :authenticate_user!
  def my_courses
    @courses = Course.find(current_user.entries.map{|entry| entry.course_id })
  end

end
