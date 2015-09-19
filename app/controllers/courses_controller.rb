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
    if @course.save
      redirect_to course_path(@course)
    else
      redirect_to :back
    end
  end
  def show
    @course = Course.find(params.permit(:id)[:id])
  end
  private
  def course_params
    params.require(:course).permit(:name, :image, :price, :price_detail, :description, :content)
  end
end
