class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, only: [:index, :destroy]
  layout 'cv', only: :edit
  def index
      @users = User.where.not(role: "admin")
      render layout: 'admin'
  end
  def edit
    if current_user.id.to_s != params.permit(:id)[:id]
      flash[:error]="你没有权限修改别人的信息"
      redirect_to '/'
    else
      @user = User.find(params.permit(:id)[:id]) 
    end
  end 
  def update
    @user = User.find(params.permit(:id)[:id])
     # to prevent user change self role 
    @user.attributes = current_user.admin? ? user_params : user_params.remove(:role)
    @user.image = parse_image_data(user_params[:image]) if user_params[:image].class == String
    unless user_params.has_key? :birthday
      birthday =params.require(:user).permit("birthday(1i)","birthday(2i)","birthday(3i)").map{|k,v| v}.join("-").to_date 
      @user.birthday =birthday 
    else
      @user.birthday = Date.parse user_params[:birthday]
    end
    if @user.save
      flash[:success]= "更新用户信息成功"
      if (current_user.role == 'admin' && current_user == @user) || !current_user.admin?
        redirect_to mypage_path 
        # modified by admin
      else
        redirect_to users_path
      end
    else
      flash[:error]= @user.errors.first 
      redirect_to :back
    end
  end 

  def destroy
    user = User.find(params.permit(:id)[:id])
    User.delete(user)
    flash[:success] = "删除用户成功"
    redirect_to users_path
  end
  private
  def user_params
    params.require(:user).permit(:birthday,:image,:email,:family_name,:gender,:role,:given_name,:phone,:school,:major,:job,:wechat,:line)
  end
  def parse_image_data(base64_image)
    filename = "upload-image"
    in_content_type, encoding, string = base64_image.split(/[:;,]/)[1..3]

    @tempfile = Tempfile.new(filename)
    @tempfile.binmode
    @tempfile.write Base64.decode64(string)
    @tempfile.rewind

    # for security we want the actual content type, not just what was passed in
    content_type = `file --mime -b #{@tempfile.path}`.split(";")[0]

    # we will also add the extension ourselves based on the above
    # if it's not gif/jpeg/png, it will fail the validation in the upload model
    extension = content_type.match(/gif|jpeg|png/).to_s
    filename += ".#{extension}" if extension

    ActionDispatch::Http::UploadedFile.new({
      tempfile: @tempfile,
      content_type: content_type,
      filename: filename
    })
  end

  def clean_tempfile
    if @tempfile
      @tempfile.close
      @tempfile.unlink
    end
  end
end
