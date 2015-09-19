class CategoriesController < ApplicationController
  layout 'admin' 
  def index
    @categories = Category.all
  end
  def new
    @category = Category.new
  end
  def create
    @post = Post.new
    @category = Category.new(category_params)
   if  @category.save
     if request.xhr?
      render 'new.js.erb'
     else
      redirect_to categories_path
     end
   else
     redirect_to :back
   end
  end
  def edit
    @category = Category.find(params.permit(:id)[:id])
  end
  def update
    category = Category.find(category_params[:id])
    category.attributes = category_params
    if  category.save
      redirect_to categories_path
    else
      redirect_to :back
    end
  end
  def destroy
    Category.destroy_all(id: params.permit(:id)[:id])
    redirect_to :back
  end
  private
  def category_params
    params.require(:category).permit(:id, :name,:slug,:border_left_color,:description)
  end
end
