class AddMoreColumnsToEmployeeMasters < ActiveRecord::Migration
  def change
    add_column :employee_masters, :father_or_husband_name, :string
    add_column :employee_masters, :relation, :string
    add_column :employee_masters, :resignation_date, :date
    add_column :employee_masters, :reason_for_resignation, :string
    add_column :employee_masters, :unusual_pf, :boolean
  end
end
