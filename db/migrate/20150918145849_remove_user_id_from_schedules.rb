class RemoveUserIdFromSchedules < ActiveRecord::Migration
  def change
    remove_column :schedules, :user_id, :integer
  end
end
