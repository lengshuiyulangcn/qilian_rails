class CreateCategoriesPosts < ActiveRecord::Migration
  def change
    create_table :categories_posts, id: false do |t|
      t.references :category, index: true, foreign_key: true, null: false
      t.references :post, index: true, foreign_key: true, null: false
    end
  end
end
