FactoryGirl.define do
  factory :comming_event, class: Event do
    title "comming event"
    description "this is the event not held yet"
    content "content of the coming event"
    timestart Date.tomorrow 
    timeend Date.tomorrow.next_month 
  end
  factory :comming_event_2, class: Event do
    title "comming event 2"
    description "this is the event2 not held yet"
    content "content of the coming event2"
    timestart Date.tomorrow 
    timeend Date.tomorrow.next_month 
  end
  factory :held_event, class: Event do
    title "the event is end"
    description "the event is held before"
    content "content of the ended event"
    timestart Date.yesterday
    timeend Date.today
  end
end
