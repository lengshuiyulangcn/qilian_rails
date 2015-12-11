class ExperiencesController < ApplicationController
  before_action :authenticate_user!, only: [:create,:destroy]
  def create
    @ex = Experience.new
    @ex.attributes = ex_params
    @ex.time_from = Time.at ex_params[:time_from].to_i
    @ex.time_to = Time.at ex_params[:time_to].to_i
    @ex.cv_id = current_user.cv.id
    if @ex.save
      render 'create.js.erb'
    end
  end
  def destroy
    @ex = Experience.find(params.permit(:id)[:id])
    if @ex.cv.user == current_user
      Experience.destroy(@ex) 
      render 'destroy.js.erb'
    end
  end
  private
  def ex_params
    params.require(:experience).permit(:time_from,:time_to,:stuff)
  end
end
