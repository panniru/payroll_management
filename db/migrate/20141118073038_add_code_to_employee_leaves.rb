class AddCodeToEmployeeLeaves < ActiveRecord::Migration
  def change
    add_column :employee_leaves, :code, :string
  end
end
