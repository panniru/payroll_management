class AddEmailToEmployeeMasters < ActiveRecord::Migration
  def change
    add_column :employee_masters, :email, :string
  end
end
