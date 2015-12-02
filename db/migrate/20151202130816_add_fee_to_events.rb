class AddFeeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :fee, :string
  end
end
