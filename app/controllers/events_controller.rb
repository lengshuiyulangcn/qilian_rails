class EventsController < ApplicationController
  layout  'admin'
  before_action :admin_only
  def index
    @events = Event.all
  end
  def new
    @event = Event.new
  end
  def create
    event = Event.new
    event.attributes = event_params
    if event.save
      redirect_to events_path 
    else
      redirect_to :back
    end
  end
  def edit 
    @event = Event.find(params.permit(:id)[:id])
  end
  def show 
    @event = Event.find(params.permit(:id)[:id])
  end
  def update 
    event = Event.find(params.permit(:id)[:id])
    event.attributes = event_params
    if event.save
      redirect_to events_path 
    else
      redirect_to :back
    end
  end

  def destroy
    post = Post.destroy_all(id: params.permit(:id)[:id])
    flash[:success]='删除成功'
    redirect_to posts_path
  end

  def event_params
    params.require(:event).permit(:id, :title, :description, :content, :image, :timestart,:timeend)
  end
end
