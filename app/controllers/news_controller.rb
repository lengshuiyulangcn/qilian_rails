class NewsController < ApplicationController
  impressionist :actions=>[:show]
  def index
    @posts = Post.all
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
    @posts = @category.posts
    @hot_posts = get_hot_passages
  end
  private
   def get_hot_passages
     #should use redis instead in the future
    Post.most_viewed
   end
end
