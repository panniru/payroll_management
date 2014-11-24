class CreateJobRuns < ActiveRecord::Migration
  def change
    create_table :job_runs do |t|
      t.string :job_code
      t.timestamp :started_on
      t.timestamp :finished_on
      t.string :status
      t.integer :scrolled_by
      t.date :job_date
    end
  end
end
