class CreateEmployeeLeaves < ActiveRecord::Migration
  def change
    create_table :employee_leaves do |t|
      t.integer :employee_master_id
      t.string :month
      t.integer :lop
      t.integer :total_days
      t.integer :working_days

      t.timestamps
    end
  end
end
