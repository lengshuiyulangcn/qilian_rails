class JobsController < ApplicationController
  layout 'admin'
  before_action :admin_only, except: [:search,:single_search,:detail]
  def index
    @jobs = Job.where(expire_at: Time.current..Time.current+1.year)
  end
  
  # multi category search
  def search
    @selected_label =[] 
    labels = params.permit(:labels=>[])[:labels]
    if labels
      graduate_jobs = Job.all.category_select(labels,'gradyear')
      category_jobs =Job.all.category_select(labels,'genre')
      industry_jobs = Job.all.category_select(labels,'industry') 
      @jobs = graduate_jobs & category_jobs & industry_jobs
      @jobs = Job.where(id: @jobs.map{|job| job.id}, expire_at: Time.current..Time.current+1.year)
      @selected_label = Label.where(id: labels )
    else
      @jobs = Job.where(expire_at: Time.current..Time.current+1.year)
    end
    @jobs = @jobs.page(params.permit(:page)[:page]).order('expire_at ASC')
    @jobs_labels = @jobs.map{|job| {job: job, labels: Job.find(job.id).labels}}
    render layout: 'normal'
  end

  # single category search
  def single_search
    label = params.permit(:id)[:id]
    @jobs = Label.find(label).jobs
    @jobs = @jobs.page(params.permit(:page)[:page]).order('expire_at ASC')
    @selected_label = [Label.find(label)]
    @jobs_labels = @jobs.map{|job| {job: job, labels: Job.find(job.id).labels}}
    render template: 'jobs/search', layout: 'normal'
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
