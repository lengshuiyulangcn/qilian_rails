class ExperiencesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
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
  private
  def ex_params
    params.require(:experience).permit(:time_from,:time_to,:stuff)
  end
end
