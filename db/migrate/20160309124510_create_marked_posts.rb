class CreateMarkedPosts < ActiveRecord::Migration
  def change
    create_table :marked_posts do |t|
      t.integer :user_id, nil: false
      t.integer :post_id, nil: false

      t.timestamps null: false
    end
  end
end
