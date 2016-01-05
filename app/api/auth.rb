class Auth < Grape::API
  format :json
  formatter :json, Grape::Formatter::Jbuilder
  resource :auth do
    desc "Creates and returns access_token if valid login"
    params do
      requires :email, type: String, desc: "Email address"
      requires :password, type: String, desc: "Password"
    end
    post :login, jbuilder: "user" do
      @user = User.where(email: params[:email]).first

      if @user && @user.valid_password?(params[:password])
        @key = ApiKey.create(user_id: @user.id)
      else
        error!('Unauthorized.', 401)
      end
    end

    desc "sign up"
    params do
      requires :email, type: String, desc: "Email address"
      requires :name, type: String, desc: "Nickname"
      requires :password, type: String, desc: "Password"
      requires :password_confirmation, type: String, desc: "Password_confirmation"
    end
    post :sign_up do
      user =  User.create!(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation],name: params[:name]) 
      if user.id
        key = ApiKey.create(user_id: user.id)
        {token: key.access_token}
      else
        error!('Unauthorized.', 401)
      end
    end

    desc "Returns pong if logged in correctly"
    params do
      requires :token, type: String, desc: "Access token."
    end
    get :ping do
      authenticate!
      { message: "pong" }
    end
  end 
  rescue_from :all do |e|
    Rails.logger.error "\n#{e.class.name} (#{e.message}):"
    e.backtrace.each { |line| Rails.logger.error line }
    error_response(message: 'Internal server error', status: 500)
  end
end
