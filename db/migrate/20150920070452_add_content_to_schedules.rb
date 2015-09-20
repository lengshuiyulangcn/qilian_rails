class AddContentToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :content, :text
  end
end
