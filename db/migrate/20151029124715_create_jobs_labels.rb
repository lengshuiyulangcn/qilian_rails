class CreateJobsLabels < ActiveRecord::Migration
  def change
    create_table :jobs_labels, id: false do |t|
      t.references :job, index: true, foreign_key: true, null: false
      t.references :label, index: true, foreign_key: true, null: false
    end
  end
end
