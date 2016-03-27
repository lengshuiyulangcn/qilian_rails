FactoryGirl.define do
  factory :admin, class: User do
    name "admin user"
    email "admin@test.com"
    password "adminuser"
    password_confirmation "adminuser"
    role "admin"
  end
  factory :teacher, class: User do
    name "teacher user"
    password "teacheruser"
    password_confirmation "teacheruser"
    role "teacher"
  end
  factory :gyorou, class: User do
    name "gyorou"
    password "normaluser"
    password_confirmation "normaluser"
    role "user"
  end
end
