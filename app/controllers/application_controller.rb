class ApplicationController < ActionController::Base


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :set_cache_headers
  respond_to :html, :json
  protect_from_forgery with: :exception
  before_action :detect_mobile
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  prepend_view_path Teamsite.resolver

  def after_sign_in_path_for(resource)
    !!session[:return_to] ? session.delete(:return_to) : mypage_path
    #request.env['omniauth.origin'] || stored_location_for(resource) || mypage_path
  end
protected

  def detect_mobile
    if (browser.device.tablet? || browser.device.mobile?) && params[:angular]
       request.variant = :mobile
    end 
  end

  def configure_devise_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :name, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
  end

  def admin_only
    unless current_user && current_user.admin?
      flash[:error]= "没有权限查看"
      redirect_to '/' 
    end
  end

  def permitted_only
    unless current_user && (current_user.admin? || current_user.teacher?)
      flash[:error]= "没有权限查看"
      redirect_to '/' 
    end
  end

  def finish_userinfo
    if current_user && current_user.phone.nil?
      flash[:error]= "请先完善用户信息"
      redirect_to edit_user_path(current_user.id) 
    end
  end
  
  private

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end  
end
