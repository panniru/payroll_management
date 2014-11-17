class AddCtcToEmployeeMasters < ActiveRecord::Migration
  def change
    add_column :employee_masters, :ctc, :integer
  end
end
