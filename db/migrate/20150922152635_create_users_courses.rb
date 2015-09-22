class CreateUsersCourses < ActiveRecord::Migration
  def change
    create_table :users_courses, id: false do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :course, index: true, foreign_key: true,null: false
    end
  end
end
