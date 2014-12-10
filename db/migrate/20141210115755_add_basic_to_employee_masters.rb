class AddBasicToEmployeeMasters < ActiveRecord::Migration
  def change
    add_column :employee_masters, :basic, :integer
  end
end
