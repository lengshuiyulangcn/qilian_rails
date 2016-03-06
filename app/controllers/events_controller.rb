class EventsController < ApplicationController
  layout  'admin'
  before_action :store_event_url, only: [:apply]
  before_action :authenticate_user!, only: [:apply]
  before_action :permitted_only, except: [:index,:show,:list,:detail,:apply]
  #before_action :finish_userinfo, only:[:apply]
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
    respond_to do |format|
      format.html do
        render layout:  'events'
      end
      format.json do render json: @event.to_json(:include=>[:users])
      end
    end
  end
  def show
    @event = Event.find(params.permit(:id)[:id])
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @event.content = markdown.render(@event.content)
    respond_to do |format|
      format.html
      format.json do 
        render json: @event.to_json(:include=>[:users])
      end
    end

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
    event = Event.destroy_all(id: params.permit(:id)[:id])
    flash[:success]='删除成功'
    redirect_to events_path
  end

  #show on public page
  def list
    @events = Event.coming_events
    respond_to do |format|
      format.html do
        render layout:  'events'
      end
      format.json do 
        events  = @events.map {|event| {event: event, users: event.users, applied: event.users.include?(current_user) }}
        render json: events 
      end
    end
  end

  def apply
    event_id = params.permit(:event_id)[:event_id]
    event =  Event.find(event_id)
    success_flag = false 
    if event.users.include? current_user
      flash[:error]="已经报名!"
    elsif event.limit && event.users.length > event.limit
      flash[:error]="已经达到报名上限!"
    else
      event.users << current_user 
      event.save
      EventMessage.apply(current_user,event).deliver
      success_flag = true 
      flash[:success]="报名活动成功!"
    end
    respond_to do |format|
      format.html do
        redirect_to :back
      end
      format.json do
        render json: {resonse: success_flag ? "ok" : "error"}
      end
    end
  end
  private
  def event_params
    params.require(:event).permit(:id, :title, :description, :content, :image, :timestart,:timeend,:limit,:fee)
  end
  def store_event_url
    unless current_user
      session[:event_id] = params.permit(:event_id)[:event_id]
      session[:return_to] = event_detail_path(params.permit(:event_id)[:event_id]) 
    end
  end
end
