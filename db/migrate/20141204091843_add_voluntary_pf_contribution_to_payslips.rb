class AddVoluntaryPfContributionToPayslips < ActiveRecord::Migration
  def change
    add_column :payslips, :voluntary_pf_contribution, :integer
  end
end
