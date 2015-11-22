class AddFakeviewToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :fakeview, :integer
  end
end
