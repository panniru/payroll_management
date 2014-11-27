class AddNoticePeriodAmountToPayslips < ActiveRecord::Migration
  def change
    add_column :payslips, :notice_period_amount, :integer
  end
end
