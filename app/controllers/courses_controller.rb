class CoursesController < ApplicationController
  layout 'admin'
  def index
    @courses = Course.all
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
    render layout: 'application'
  end
  private
  def course_params
    params.require(:course).permit(:id, :name, :image, :price, :price_detail, :description, :content)
  end
end
