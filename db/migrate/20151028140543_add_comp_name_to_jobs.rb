class AddCompNameToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :comp_name, :string
  end
end
