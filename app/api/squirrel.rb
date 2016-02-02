module Squirrel
  class API < Grape::API
    helpers do  
      def authenticate!
        error!('Unauthorized. Invalid or expired token.', 401) unless current_user
      end

      def current_user
        # get token
        token = ApiKey.where(access_token: params[:token]).first
        if token && !token.expired?
          @current_user = User.find(token.user_id)
        else
          false
        end
      end
    end
    mount Zipcode
    mount Auth
    mount NewsService::News
    mount JobSearch::JobSearch
  end
end
