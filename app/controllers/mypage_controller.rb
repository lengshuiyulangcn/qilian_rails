class MypageController < ApplicationController
  before_action :authenticate_user!
  def editinfo
    if current_user.id != params.permit(:id)[:id]
      flash[:error]="你没有权限修改别人的信息"
      redirect_to '/'
    else
    @user = User.find(params.permit(:id)[:id]) 
    end
  end
 private
  def user_params
    params.require(:user).permit(:family_name,:given_name,:phone,:school,:major,:job,:wechat,:line)
  end

end
