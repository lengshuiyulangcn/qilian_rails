class QilianMailController < ApplicationController
  before_action :admin_only
  layout "admin"
  def new
  end

  def create
    title = params[:title]
    content = params[:content]
    SendMailJob.perform_later(title,content)
    flash[:success]="创建群发邮件成功,请注意查看邮箱"
    redirect_to admin_home_path
  end

end
