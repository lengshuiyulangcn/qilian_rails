class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :user_id,  index: true, null: false
      t.integer :course_id, index: true, null: false

      t.timestamps null: false
    end
  end
end
