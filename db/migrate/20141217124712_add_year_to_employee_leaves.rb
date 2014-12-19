class AddYearToEmployeeLeaves < ActiveRecord::Migration
  def change
    add_column :employee_leaves, :year, :integer
  end
end
