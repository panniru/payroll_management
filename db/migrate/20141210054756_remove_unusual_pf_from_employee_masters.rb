class RemoveUnusualPfFromEmployeeMasters < ActiveRecord::Migration
  def change
    remove_column :employee_masters, :unusual_pf, :boolean
  end
end
