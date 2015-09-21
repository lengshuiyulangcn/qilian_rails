class NewsController < ApplicationController
  def show
    @post = Post.find(params.permit(:id)[:id])
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @post.content = markdown.render(@post.content)
  end
end
