class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :image
      t.string :address
      t.datetime :starttime
      t.datetime :endtime
      t.text :description
      t.string :price
      t.string :price_detail

      t.timestamps null: false
    end
  end
end
