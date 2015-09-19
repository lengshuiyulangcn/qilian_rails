class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :name
      t.datetime :datetime_from
      t.datetime :datetime_to
      t.string :address
      t.integer :limit
      t.string :status

      t.timestamps null: false
    end
  end
end
