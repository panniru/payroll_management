class AddEnteredDateToEmployeeLeaves < ActiveRecord::Migration
  def change
    add_column :employee_leaves, :entered_date, :date
  end
end
