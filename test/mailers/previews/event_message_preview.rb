# Preview all emails at http://localhost:3000/rails/mailers/event_message
class EventMessagePreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/event_message/apply
  def apply
    EventMessage.apply
  end

end
