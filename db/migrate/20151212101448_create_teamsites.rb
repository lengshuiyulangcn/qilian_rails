class CreateTeamsites < ActiveRecord::Migration
  def change
    create_table :teamsites do |t|
      t.string :path
      t.string :description
      t.text :body
      t.string :locale
      t.string :handler, default: 'erb' 
      t.boolean :partial, default: true 
      t.string :format, default: "html"

      t.timestamps null: false
    end
  end
end
