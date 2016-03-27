FactoryGirl.define do
  factory :post1, class: Post do
    title "test post 1"
    description "this is test post 1"
    content "This is a Sample Article."
  end
  factory :post2, class: Post do
    title "test post 2"
    description "this is test post 2"
    content "This is a Sample Article of post2."
  end
end
