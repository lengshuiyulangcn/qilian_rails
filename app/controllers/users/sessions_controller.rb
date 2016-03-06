class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    if session[:event_id]
      apply_event
      return
    else
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  private

  def apply_event
    event_id = session.delete(:event_id)
    session.delete(:return_to)
    event =  Event.find(event_id)
    if event.users.include? current_user
      flash[:error]="已经报名!"
    elsif event.limit && event.users.length > event.limit
      flash[:error]="已经达到报名上限!"
    else
      event.users << current_user 
      event.save
      EventMessage.apply(current_user,event).deliver
      flash[:success]="报名活动成功!"
    end
    redirect_to event_detail_path(event_id)
  end
end
