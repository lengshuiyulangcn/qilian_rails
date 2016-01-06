class QilianMessage < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.qilian_message.send_all.subject
  #
  def send_all(user,title,content)
    @content = content
    @user = user
    mail(
      to:      user.email,
      subject: title,
    	) do |format|
      format.html
    end
  end
end
