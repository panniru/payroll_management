class PfStatement < ActiveRecord::Base
  belongs_to :employee_master
  belongs_to :payslip
end
