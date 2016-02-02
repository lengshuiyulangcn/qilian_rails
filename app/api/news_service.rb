module NewsService
  class News < Grape::API
    format :json
    formatter :json, Grape::Formatter::Jbuilder
    resource :news do
      desc "get news list"
      paginate
      params do
        optional :page,     type: Integer
        optional :per_page, type: Integer
      end
      get '/', jbuilder: 'index' do
        @page = params[:page] ? params[:page] : 1
        @per_page = params[:per_page] ? params[:per_page] : 30 
        @total_page = Post.all.length/@per_page+1
        @posts = paginate Post.all.order(created_at: "DESC")
      end
      desc "get one news"
      params do
        requires :id, type: Integer
      end
      get ":id", jbuilder: 'post' do
        @post = Post.find(params[:id])
        @post.content = @post.markdown
      end
    end
    desc "get by category id"
    paginate
    params do
      requires :category_id, type: Integer
      optional :page,     type: Integer
      optional :per_page, type: Integer
    end
    get :category, jbuilder: 'index' do
      posts = Post.includes(:categories).where(categories: {id: params[:category_id]}).order(created_at: "DESC")
      @posts = paginate posts
      @category_name = Category.find(params[:category_id]).name
      @page = params[:page] ? params[:page] : 1
      @per_page = params[:per_page] ? params[:per_page] : 30 
      @total_page = posts.length/@per_page+1
    end
  end
end
