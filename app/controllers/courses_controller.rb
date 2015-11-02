class CoursesController < ApplicationController
  before_action :admin_only, except: [:all,:detail]
  layout 'admin'
  def index
    @courses = Course.all
    respond_to do |format|
      format.html
      format.json do 
        courses = @courses.map {|course| {course: course, teachers: course.users, entries: course.entries}}
        render json: courses
      end
    end
  end
  
  def all
    @courses = Course.all
    render layout: 'application'
  end

  def new
    @course =Course.new
  end
  def create
    @course = Course.new
    @course.attributes = course_params
    @course.users = User.where(name: params.require(:course).permit(:users=>[])[:users])
    if @course.save
      redirect_to course_path(@course)
    else
      redirect_to :back
    end
  end
  def show
    @course = Course.find(params.permit(:id)[:id])
    @users = User.find(@course.entries.map{|entry| entry.user_id })
    respond_to do |format|
      format.html
      format.json do 
        render json: @course.to_json(:include=>[:schedules,:users,:entries])

      end
    end
  end
  def edit
    @course = Course.find(params.permit(:id)[:id])
  end
  def update
    @course = Course.find(course_params[:id])
    @course.attributes = course_params
    @course.users = User.where(name: params.require(:course).permit(:users=>[])[:users])
    if @course.save
      redirect_to course_path(@course)
    else
      redirect_to :back
    end
  end
  def detail
    @course = Course.find(params.permit(:id)[:id])
    @current_students = Entry.where(course_id: @course.id).map{|entry| entry.user_id }
    render layout: 'application'
  end
  private
  def course_params
    params.require(:course).permit(:id, :name, :image, :price, :price_detail, :description, :content, :starttime, :endtime)
  end
end
