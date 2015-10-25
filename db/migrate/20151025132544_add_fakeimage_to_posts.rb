class AddFakeimageToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :fakeimage, :string
  end
end
