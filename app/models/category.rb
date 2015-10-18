class Category < ActiveRecord::Base
  has_and_belongs_to_many :posts
  belongs_to :father, class_name: "Category", foreign_key: :father_id
end
