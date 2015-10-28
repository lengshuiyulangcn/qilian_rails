class JobsController < ApplicationController
  layout 'admin'
  def index
    @jobs = Job.all
  end
  def new
    @job = Job.new
  end
  def edit
    @job = Job.find(params.permit(:id)[:id])
  end
  def create
    @job = Job.new
    @job.attributes = job_params
    if @job.save 
      flash[:success]='创建求人信息成功'
      redirect_to jobs_path
    else
      flash[:error]='创建求人信息失败'
      redirect_to :back
    end
  end
  def update
    @job = Job.find(params.permit(:id)[:id])
    @job.attributes = job_params
    if @job.save 
      flash[:success]='修改求人信息成功'
      redirect_to jobs_path
    else
      flash[:error]='创建求人信息失败'
      redirect_to :back
    end
  end

  private
  def job_params
    params.require(:job).permit(:id,:title,:comp_name,:content,:detail,:schedule,:position,:expire_at,:image)
  end
end
