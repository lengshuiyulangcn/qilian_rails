class NewsController < ApplicationController
  def show
    @post = Post.find(params.permit(:id)[:id])
  end
end
