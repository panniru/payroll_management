class ChangeDaysWorkedToFloatEmployeeLeaves < ActiveRecord::Migration
  def change
    change_column :employee_leaves, :days_worked, :float
  end
end
