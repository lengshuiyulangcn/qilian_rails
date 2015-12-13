class ApplicationController < ActionController::Base


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  respond_to :html, :json
  protect_from_forgery with: :exception
  before_action :detect_mobile
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  prepend_view_path Teamsite.resolver


protected

def detect_mobile
  if (browser.tablet? || browser.mobile?) && params[:angular]
     request.variant = :mobile
  end 
end

def configure_devise_permitted_parameters
  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
  devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :name, :email, :password, :remember_me) }
  devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
end

def admin_only
  if  !current_user || current_user.role!= "admin"  
    flash[:error]= "你没有管理员权限"
    redirect_to '/' 
  end
end

def finish_userinfo
  if current_user && current_user.phone.nil?
    flash[:error]= "请先完善用户信息"
    redirect_to edit_user_path(current_user.id) 
  end
end
end
