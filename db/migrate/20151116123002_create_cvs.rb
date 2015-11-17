class CreateCvs < ActiveRecord::Migration
  def change
    create_table :cvs do |t|
      t.string :name
      t.string :kana
      t.timestamp :birthday
      t.string :gender
      t.string :home_phone
      t.string :cell_phone
      t.string :email
      t.string :current_address
      t.string :emergency_address
      t.string :skill
      t.string :interest
      t.string :major_work
      t.string :self_pr
      t.string :best_effort
      t.string :image

      t.timestamps null: false
    end
  end
end
