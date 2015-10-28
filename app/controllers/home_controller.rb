class HomeController < ApplicationController
  
  def index
    redirect_to news_index_path
  end
end
