module MypageHelper
  def my_list
    events = current_user.events
    courses = Course.find(current_user.entries.map{|entry| entry.course_id })
  end
end
