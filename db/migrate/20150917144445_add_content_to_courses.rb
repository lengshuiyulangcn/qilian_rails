class AddContentToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :content, :text
  end
end
