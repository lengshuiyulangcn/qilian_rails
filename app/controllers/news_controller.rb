class NewsController < ApplicationController
  impressionist :actions=>[:show]
  def index
    @posts = Post.page(params.permit(:page)[:page]).order('sticky desc, created_at DESC')
    @hot_posts = get_hot_passages
  end
  def show
    @post = Post.find(params.permit(:id)[:id])
    need_login = @post.categories.exists?(need_login: true) 
    if need_login && !current_user
      flash[:error]="该分类需要登录方可查看。利用facebook可快速登录。"
      redirect_to new_user_session_path
      return
    end
    impressionist(@post, nil, :unique => [:session_hash])
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @post.content = markdown.render(@post.content)
    @count = @post.impressionist_count
    @hot_posts = get_hot_passages
  end
  def category
    @category = Category.find(params.permit(:id)[:id])
    @posts = @category.posts.scope.page(params.permit(:page)[:page]).order('sticky desc, created_at DESC')
    @hot_posts = get_hot_passages
    respond_to do |format|
      format.html
      format.json do
        @posts = @category.posts
        render json: @posts
      end
    end
  end
  def search
    query = "site:qilian.jp+#{params.permit(:q)[:q]}"
    redirect_to "http://www.google.jp/search?q=#{query}" 
  end
  private
   def get_hot_passages
     #should use redis instead in the future
    Post.most_viewed
   end
end
