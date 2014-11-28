class AddIndexOnNameAndCodeToEmployeeMasters < ActiveRecord::Migration
  def change
    add_index :employee_masters, :code
    add_index :employee_masters, :name
  end
end
