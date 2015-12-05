class AddExstrToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :exstr, :string
  end
end
