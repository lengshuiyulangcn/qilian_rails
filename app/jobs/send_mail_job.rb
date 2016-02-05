require 'redcarpet'
class SendMailJob < ActiveJob::Base
  queue_as :default

  def perform(title, content)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    content = markdown.render(content)
    User.all.each do |user|
      QilianMessage.send_all(user,title,content).deliver
    end
  end
end
