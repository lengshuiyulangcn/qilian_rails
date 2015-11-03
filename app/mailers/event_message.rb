class EventMessage < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_message.apply.subject
  #
  def apply(user, event)
    @user = user
    @event = event
    mail(
      to:      user.email,
      subject: "成功报名活动:#{event.title}",
    	) do |format|
      format.html
    end   
  end
end
