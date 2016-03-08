class AddFakeimageToEvents < ActiveRecord::Migration
  def change
    add_column :events, :fakeimage, :string
  end
end
