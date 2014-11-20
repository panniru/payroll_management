class RenameTotalDaysToDaysWorkedInEmployeeLeaves < ActiveRecord::Migration
  def change
    rename_column :employee_leaves, :total_days, :days_worked
  end
end
