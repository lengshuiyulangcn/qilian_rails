class AddNeedLoginToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :need_login, :boolean, default: false
  end
end
