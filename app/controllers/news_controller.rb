class NewsController < ApplicationController
  impressionist :actions=>[:show]
  def index
    @posts = Post.page(params.permit(:page)[:page]).order('created_at DESC')
    @hot_posts = get_hot_passages
  end
  def show
    @post = Post.find(params.permit(:id)[:id])
    impressionist(@post, nil, :unique => [:session_hash])
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @post.content = markdown.render(@post.content)
    @count = @post.impressionist_count
    @hot_posts = get_hot_passages
  end
  def category
    @category = Category.find(params.permit(:id)[:id])
    @posts = @category.posts.page(params.permit(:page)[:page]).order('created_at DESC')
    @hot_posts = get_hot_passages
    respond_to do |format|
      format.html
     @posts = @category.posts
        format.json do
        render json: @posts
      end
    end
  end
  private
   def get_hot_passages
     #should use redis instead in the future
    Post.most_viewed
   end
end
