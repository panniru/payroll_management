class Payslip < ActiveRecord::Base
  belongs_to :employee_master

  scope :in_the_current_month, lambda{|month, year| where("to_char(generated_date, 'Mon') = ? and to_char(generated_date, 'YYYY') = ?", month[0..2], year)}
  scope :in_the_year, lambda{|year| where("to_char(generated_date, 'YYYY') = ?", year)}
  scope :in_the_month, lambda{|month| where("to_char(generated_date, 'Mon') = ?", month[0..2])}
  scope :belongs_to_employee, lambda{|employee_id| where(:employee_master_id =>  employee_id)}
  scope :having_status, lambda{|status| where(:status =>  status)}

  
  validates :basic, :hra, :conveyance_allowance, :city_compensatory_allowance, :special_allowance, :loyalty_allowance, :medical_allowance, :arrears_of_salary, :incentive_payment, :loyalty_deposit, :grade_allowance, :leave_settlement, :performance_bonus, :additional_allowance_1, :additional_allowance_2, :additional_allowance_3, :pf, :club_contribution, :proffesional_tax, :tds_pm, :training_cost, :salary_advance, :additional_deduction_1, :additional_deduction_2, :additional_deduction_3, allow_blank: true, numericality: { only_integer: true }

  EARNINGS = [:basic, :hra, :conveyance_allowance, :city_compensatory_allowance, :special_allowance, :loyalty_allowance, :medical_allowance, :arrears_of_salary, :incentive_payment, :loyalty_deposit, :grade_allowance, :leave_settlement, :performance_bonus, :additional_allowance_1, :additional_allowance_2, :additional_allowance_3]

  DEDUCTIONS = [:pf, :club_contribution, :proffesional_tax, :tds_pm, :training_cost, :salary_advance, :additional_deduction_1, :additional_deduction_2, :additional_deduction_3]

  def self.payslips_on_params(params, page = nil)
    payslips = Payslip
    if params[:employee_master_id].present? or params[:month].present? or params[:year].present? or params[:status].present?
      payslips = payslips.belongs_to_employee(params[:employee_master_id]) if params[:employee_master_id].present?
      payslips = payslips.in_the_month(params[:month]) if params[:month].present?
      payslips = payslips.in_the_year(params[:year]) if params[:year].present?
      payslips = payslips.having_status(params[:status]) if params[:status].present?
      payslips = payslips.paginate(:page => page) if page.present?
    end
    payslips
  end

  def change_status(status)
    self.update_attributes({:status => status})
  end

  def total_earnings
    basic.to_i + hra.to_i + conveyance_allowance.to_i + city_compensatory_allowance.to_i + special_allowance.to_i + loyalty_allowance.to_i + medical_allowance.to_i + arrears_of_salary.to_i + incentive_payment.to_i + loyalty_deposit.to_i + grade_allowance.to_i + leave_settlement.to_i + performance_bonus.to_i + additional_allowance_1.to_i + additional_allowance_2.to_i + additional_allowance_3.to_i
  end

  def total_deductions
    (pf.to_i + club_contribution.to_i + proffesional_tax.to_i + tds_pm.to_i + training_cost.to_i + salary_advance.to_i + additional_deduction_1.to_i + additional_deduction_2.to_i + additional_deduction_3.to_i)
  end

  def ctc
    (employee_master.ctc.to_f/12).round
  end
  
  def net_total
    (total_earnings - total_deductions)
  end

end
