require 'redcarpet'
class PostsController < ApplicationController
  layout  'admin'
  def index
    @posts = Post.all
  end
  def new
    @post = Post.new
    @categories = Category.all
  end
  def show
    @post = Post.find(params.permit(:id)[:id])
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @post.content = markdown.render(@post.content)
  end
  def edit
    @post = Post.find(params.permit(:id)[:id])
    @categories = Category.all
  end
  def create
    @post = Post.new
    @post.attributes = post_params.permit(:title, :description, :content, :image)
    @post.categories = Category.where(name: post_params[:categories])
    if @post.save 
      flash[:success]='创建文章成功'
      redirect_to post_path(@post)
    else
      flash[:error]='创建文章失败'
      redirect_to :back
    end
  end

  def update
    @post = Post.find(post_params[:id])
    @post.attributes = post_params.permit(:title, :description, :content, :image)
    @post.categories = Category.where(name: post_params[:categories])
    if @post.save 
      flash[:success]='修改文章成功'
      redirect_to post_path(@post)
    else
      flash[:error]='修改文章失败'
      redirect_to :back
    end
  end
  def destroy
    flash[:success]='删除文章成功'
    post = Post.destroy_all(id: params.permit(:id)[:id])
    redirect_to posts_path
  end
  private

  def post_params
    params.require(:post).permit(:id, :title, :description, :content, :image, :categories=>[])
  end
end
