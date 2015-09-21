class AddColunmsToUser < ActiveRecord::Migration
  def change
    add_column :users, :family_name, :string
    add_column :users, :given_name, :string
    add_column :users, :phone, :string
    add_column :users, :school, :string
    add_column :users, :major, :string
    add_column :users, :job, :string
    add_column :users, :wechat, :string
    add_column :users, :line, :string
  end
end
