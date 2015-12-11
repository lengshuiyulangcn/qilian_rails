class CvsController < ApplicationController
  before_action :authenticate_user!
  layout 'cv'
  def index
    @cvs = Cv.all
  end
  def edit
    @cv = Cv.find(params.permit(:id)[:id])
    if current_user!= @cv.user
      flash[:error]="你无法修改别人的简历"
      redirect_to mypage_path 
    else
      @experiences = @cv.experiences.order(:time_from)
    end
  end
  def show
    @cv = Cv.find(params.permit(:id)[:id])
    unless current_user== @cv.user or  current_user.role=="admin" 
      @experiences = @cv.experiences.order(:time_from)
    else
      flash[:error]="你无法查看别人的简历"
      redirect_to mypage_path 
    end
  end
  def update 
    cv = Cv.find(params.permit(:id)[:id])
    cv.attributes = cvs_params
    unless cvs_params.has_key? :birthday
      birthday =params.require(:cv).permit("birthday(1i)","birthday(2i)","birthday(3i)").map{|k,v| v}.join("-").to_date 
      cv.birthday =birthday 
    else
      cv.birthday = Date.parse cvs_params[:birthday]
    end
    if cv.save
      flash[:success]="修改简历成功"
      redirect_to cv_path(cv) 
    end
  end
  private
  def cvs_params
    params.require(:cv).permit(:id,:name,:kana,:home_phone,:cell_phone,:gender,:birthday,:current_address,:emergency_address,:skill,:interest,:major_work,:self_pr,:best_effort,:image)
  end
end
