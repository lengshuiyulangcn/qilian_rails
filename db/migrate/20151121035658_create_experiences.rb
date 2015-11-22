class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.timestamp :time_from
      t.timestamp :time_to
      t.string :stuff

      t.timestamps null: false
    end
  end
end
