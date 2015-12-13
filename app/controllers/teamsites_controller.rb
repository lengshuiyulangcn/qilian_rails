class TeamsitesController < ApplicationController
  before_action :admin_only
  layout 'admin'
  def index
    @teamsites = Teamsite.all
  end
  def new
    @teamsite = Teamsite.new
  end
  def show
    @teamsite = Teamsite.find(params.permit(:id)[:id])
  end
  def edit
    @teamsite = Teamsite.find(params.permit(:id)[:id])
  end
  def update
    @teamsite = Teamsite.find(params.permit(:id)[:id])
    if  @teamsite.update(teamsites_params)
      flash[:success]="更新静态页面成功"
    else
      flash[:error]="更新静态页面失败"
    end
    redirect_to teamsites_path
  end
  def create
    teamsite = Teamsite.new
    teamsite.attributes = teamsites_params
    teamsite.locale = 'en' 
    if teamsite.save!
      flash[:success]="创建静态页面成功"
    else
      flash[:error]="创建静态页面失败"
    end
      redirect_to teamsites_path
  end
  def destroy
    @teamsite = Teamsite.find(params.permit(:id)[:id])
    Teamsite.destroy(@teamsite)
    flash[:success]="删除静态页面成功"
    redirect_to teamsites_path
  end
  private
    def teamsites_params
      params.require(:teamsite).permit(:id,:path,:description,:body)
    end
end
