class LabelsController < ApplicationController
  layout 'admin' 
  def index
    @labels = Label.all
    respond_to do |format|
      format.html
      format.json {render json: @labels}
    end
  end
  def new
    @label = Label.new
  end
  def create
    @post = Job.new
    @label = Label.new(label_params)
   if  @label.save
     if request.xhr?
      render 'new.js.erb'
     else
      redirect_to labels_path
     end
   else
     redirect_to :back
   end
  end
  def edit
    @label = Label.find(params.permit(:id)[:id])
  end
  def update
    label = Label.find(label_params[:id])
    label.attributes = label_params
    if  label.save
      redirect_to labels_path
    else
      redirect_to :back
    end
  end
  def destroy
    Label.destroy_all(id: params.permit(:id)[:id])
    redirect_to :back
  end
  private
  def label_params
    params.require(:label).permit(:id, :name,:category)
  end
end
