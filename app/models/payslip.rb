class Payslip < ActiveRecord::Base
  belongs_to :employee_master
  validates :basic, :hra, :conveyance_allowance, :city_compensatory_allowance, :special_allowance, :loyalty_allowance, :medical_allowance, :arrears_of_salary, :incentive_payment, :loyalty_deposit, :grade_allowance, :leave_settlement, :performance_bonus, :additional_allowance_1, :additional_allowance_2, :additional_allowance_3, :pf, :club_contribution, :proffesional_tax, :tds_pm, :training_cost, :salary_advance, :additional_deduction_1, :additional_deduction_2, :additional_deduction_3, allow_blank: true, numericality: { only_integer: true }
end
