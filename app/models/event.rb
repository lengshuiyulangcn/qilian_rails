class Event < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  
  def self.coming_events
    self.where(timestart: Date.today..Date.today.next_month.beginning_of_month )
  end
  def self.full_calendar_event
    Event.all.map{|event| {id: event.id, title: event.title, start: event.timestart}} 
  end
end
