class AddDateOfBirthToEmployeeMasters < ActiveRecord::Migration
  def change
    add_column :employee_masters, :date_of_birth, :date
  end
end
