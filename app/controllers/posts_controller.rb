class PostsController < ApplicationController
  layout  'admin'
  def index
    @posts = Post.all
  end
  def new
    @post = Post.new
  end
end
