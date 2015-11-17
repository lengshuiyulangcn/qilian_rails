class CvsController < ApplicationController
  before_action :authenticate_user!
  def index
    @cvs = Cv.all
  end
  def new
    @cv = Cv.new
  end
  def create
    cv = Cv.new
    cv.attributes = cvs_params
    unless cvs_params.has_key? :birthday
      birthday =params.require(:cv).permit("birthday(1i)","birthday(2i)","birthday(3i)").map{|k,v| v}.join("-").to_date 
      cv.birthday =birthday 
    else
      cv.birthday = Date.parse cvs_params[:birthday]
    end
    if cv.save
      redirect_to :back 
    end
  end
  private
  def cvs_params
    params.require(:cv).permit(:id,:name,:kana,:home_phone,:cell_phone,:gender,:birthday,:current_address,:emergency_address,:skill,:interest,:major_work,:self_pr,:best_effort,:image)
  end
end
