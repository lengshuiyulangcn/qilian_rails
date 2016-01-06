class SendMailJob < ActiveJob::Base
  queue_as :default

  def perform(title, content)
    User.all.each do |user|
      QilianMessage.send_all(user,title,content).deliver
    end
  end
end
