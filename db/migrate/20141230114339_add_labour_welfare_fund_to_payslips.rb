class AddLabourWelfareFundToPayslips < ActiveRecord::Migration
  def change
    add_column :payslips, :labour_welfare_fund, :integer
  end
end
