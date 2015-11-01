class AddFakeimageToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :fakeimage, :string
  end
end
