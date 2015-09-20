class SchedulesController < ApplicationController
skip_before_action :verify_authenticity_token  
 def create
   @schedule = Schedule.new
   @schedule.attributes = schedule_params
   if @schedule.save
    render json: Schedule.where(course_id: schedule_params[:course_id]).all.to_json 
   else
    render nothing: true, status: 500 
   end
  end
  private
  def schedule_params
    params.permit(:id, :name,:limit, :course_id, :datetime_from, :datetime_to, :address, :status)
  end
end
