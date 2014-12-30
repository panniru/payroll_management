class AddSpecialAllowanceToEmployeeMasters < ActiveRecord::Migration
  def change
    add_column :employee_masters, :special_allowance, :integer
  end
end
