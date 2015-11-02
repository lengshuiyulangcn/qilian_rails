class CreateEventsUsers < ActiveRecord::Migration
  def change
    create_table :events_users, id: false do |t|
      t.references :event, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
    end
  end
end
