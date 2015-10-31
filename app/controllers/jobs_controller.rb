class JobsController < ApplicationController
  layout 'admin'
  def index
    @jobs = Job.all
  end

  def search
    jobs = Job.all
    @selected_label =[] 
    @jobs = jobs.map{|job| {job: job, labels: job.labels}}
    render layout: 'normal'
  end

  def new
    @job = Job.new
    @labels = Label.all
  end
  def detail
    @job = Job.find(params.permit(:id)[:id])
    render layout: 'normal'
  end
  def edit
    @job = Job.find(params.permit(:id)[:id])
    @labels = Label.all
  end
  def create
    @job = Job.new
    @job.attributes = job_params
    @job.labels = Label.where(name: get_labels[:labels])
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
    @job.labels = Label.where(name: get_labels[:labels])
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
  def get_labels
    params.require(:job).permit(:labels=>[])
  end
end
