class AddStatusToEmployeeMasters < ActiveRecord::Migration
  def change
    add_column :employee_masters, :status, :string
  end
end
