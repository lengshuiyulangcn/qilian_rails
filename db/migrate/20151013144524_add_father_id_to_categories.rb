class AddFatherIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :father_id, :integer
  end
end
