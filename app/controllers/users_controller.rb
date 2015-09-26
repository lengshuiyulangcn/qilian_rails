class UsersController < ApplicationController
  before_action :admin_only, only: :index
  layout 'admin', only: :index
  def index
      @users = User.all
  end
  def edit
    if current_user.id.to_s != params.permit(:id)[:id]
      flash[:error]="你没有权限修改别人的信息"
      redirect_to '/'
    else
      @user = User.find(params.permit(:id)[:id]) 
    end
  end 
  def update
    @user = User.find(params.permit(:id)[:id]) 
    @user.attributes = user_params 
    birthday =params.require(:user).permit("birthday(1i)","birthday(2i)","birthday(3i)").map{|k,v| v}.join("-").to_date 
    @user.birthday =birthday 
    if @user.save
      flash[:success]= "更新用户表单成功"
      redirect_to mypage_path if current_user.role != 'admin'
      redirect_to users_path
    else
      flash[:error]= @user.errors.first 
      redirect_to :back
    end
  end 
  private
  def user_params
    params.require(:user).permit(:image,:email,:family_name,:gender,:role,:given_name,:phone,:school,:major,:job,:wechat,:line)
  end
end
