require 'redcarpet'
class PostsController < ApplicationController
  layout  'admin'
  def index
    @posts = Post.all
  end
  def new
    @post = Post.new
  end
  def show
    @post = Post.find(params.permit(:id)[:id])
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @post.content = markdown.render(@post.content)
  end
  def edit
    @post = Post.find(params.permit(:id)[:id])
  end
  def create
    @post = Post.new
    @post.attributes = post_params
    redirect_to :back unless @post.save 
    redirect_to post_path(@post)
  end

  def update
    post = Post.find(post_params[:id])
    post.attributes = post_params
    redirect_to :back unless post.save 
    redirect_to post_path(post)
  end
  def destroy
    post = Post.destroy_all(id: params.permit(:id)[:id])
    redirect_to posts_path
  end
  private

  def post_params
    params.require(:post).permit(:id, :title, :description, :content)
  end
end
