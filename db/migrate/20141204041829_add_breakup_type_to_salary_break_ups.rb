class AddBreakupTypeToSalaryBreakUps < ActiveRecord::Migration
  def change
    add_column :salary_break_ups, :break_up_type, :string
  end
end
