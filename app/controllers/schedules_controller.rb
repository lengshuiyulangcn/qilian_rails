class SchedulesController < ApplicationController
  def create
   @schedule = Schedule.new
   @schedule.attributes = schedule_params
   if @schedule.save
    render @shedule.to_json 
   else
    render {'error': 'failure'}.to_json
   end
  end
  private
  def schedule_params
    params.require(:shedule).permit(:id,:name,:course_id, :datetime_from, :datetime_to, :address, :status)
  end
end
