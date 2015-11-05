class EventsController < ApplicationController
  layout  'admin'
  before_action :authenticate_user!, only: [:apply]
  before_action :admin_only, except: [:index,:show,:list,:detail,:apply]
  before_action :finish_userinfo, only:[:apply]
  def index
    @events = Event.all
    respond_to do |format|
      format.html
      format.json do 
        events  = @events.map {|event| {event: event, users: event.users }}
        render json: events 
      end
    end
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
  def detail 
    @event = Event.find(params.permit(:id)[:id])
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @event.content = markdown.render(@event.content)
    render layout:  'normal'
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

  #show on public page
  def list
    @events = Event.coming_events
    render layout:  'normal'
  end
  def apply
      event_id = params.permit(:event_id)[:event_id]
      event =  Event.find(event_id)
      unless event.users.include? current_user
        event.users << current_user 
        event.save
        EventMessage.apply(current_user,event).deliver
        flash[:success]="报名活动成功!"
      else
        flash[:error]="已经报名!"
      end
      redirect_to :back
  end
  private
  def event_params
    params.require(:event).permit(:id, :title, :description, :content, :image, :timestart,:timeend)
  end
end
