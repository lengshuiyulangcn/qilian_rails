class AddTimeendToEvent < ActiveRecord::Migration
  def change
    add_column :events, :timeend, :timestamp
  end
end
