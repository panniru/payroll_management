class PfStatement < ActiveRecord::Base
  belongs_to :employee_master
  belongs_to :payslip


  def self.pf_statement_applicable_date(date)
    date.prev_month
  end
end
