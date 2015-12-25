module NewsService
  class News < Grape::API
    format :json
    resource :news do
      desc "get news list"
      params do
        optional :page, type: Integer
      end
      get :index do
      end
    end
  end
end
