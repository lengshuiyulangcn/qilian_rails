class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :content
      t.string :position
      t.timestamp :expire_at
      t.text :detail
      t.string :step
      t.text :target
      t.text :schedule
      t.string :location
      t.string :num
      t.string :source_url
      t.string :image

      t.timestamps null: false
    end
  end
end
