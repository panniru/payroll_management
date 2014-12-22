class AddPayslipsIdToForm24 < ActiveRecord::Migration
  def change
    add_column :form24s, :payslips_id, :integer
  end
end
