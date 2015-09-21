class AdminController < ApplicationController
  before_action :admin_only
 def index
 end 
 def userinfo
   @user = User.find(params.permit(:id)[:id])
 end
end
