class Payslip < ActiveRecord::Base
  belongs_to :employee_master
  has_one :employer_contribution
  has_one :payslip_additional_fields_label
  belongs_to :form24
  validates :basic, :hra, :conveyance_allowance, :city_compensatory_allowance, :special_allowance, :loyalty_allowance, :medical_allowance, :arrears_of_salary, :incentive_payment, :loyalty_deposit, :grade_allowance, :leave_settlement, :performance_bonus, :additional_allowance_1, :additional_allowance_2, :additional_allowance_3, :pf, :club_contribution, :professional_tax, :tds_pm, :training_cost, :salary_advance, :additional_deduction_1, :additional_deduction_2, :additional_deduction_3, :notice_period_amount, allow_blank: true, numericality: { only_integer: true }

  attr_accessor :additional_allowance_1_label, :additional_allowance_2_label, :additional_allowance_3_label
  attr_accessor :additional_deduction_1_label, :additional_deduction_2_label, :additional_deduction_3_label

  EARNINGS = [:basic, :hra, :conveyance_allowance, :city_compensatory_allowance, :special_allowance, :loyalty_allowance, :medical_allowance, :arrears_of_salary, :incentive_payment, :loyalty_deposit, :grade_allowance, :leave_settlement, :performance_bonus, :additional_allowance_1, :additional_allowance_2, :additional_allowance_3]

  DEDUCTIONS = [:pf, :club_contribution, :professional_tax, :tds_pm, :training_cost, :salary_advance, :notice_period_amount, :voluntary_pf_contribution, :additional_deduction_1, :additional_deduction_2, :additional_deduction_3]

  scope :in_the_current_month, lambda{|date| in_the_month(date.strftime("%b")).in_the_year(date.strftime("%Y"))}
  scope :in_the_year, lambda{|year| where("to_char(generated_date, 'YYYY') = ?", year)}
  scope :in_the_month, lambda{|month| where("to_char(generated_date, 'Mon') = ?", month[0..2])}
  scope :in_the_mon, lambda{|month| where("EXTRACT(month from generated_date) = ?" , month)}
  scope :belongs_to_employee, lambda{|employee_id| where(:employee_master_id =>  employee_id)}
  scope :having_status, lambda{|status| where(:status =>  status)}
  scope :having_loyality_allowance, lambda{ where("loyalty_allowance IS NOT NULL")}
  scope :having_annual_bonus, lambda{ where("annual_bonus IS NOT NULL")}
  scope :generated_between, lambda{|from_date, to_date| where(:generated_date => (from_date..to_date))}



  def self.payslips_on_params(params)
    payslips = Payslip.all
    if params[:employee_master_id].present? or params[:month].present? or params[:year].present? or params[:status].present?
      payslips = payslips.belongs_to_employee(params[:employee_master_id]) if params[:employee_master_id].present?
      payslips = payslips.in_the_month(params[:month]) if params[:month].present?
      payslips = payslips.in_the_year(params[:year]) if params[:year].present?
      payslips = payslips.having_status(params[:status]) if params[:status].present?
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
    (pf.to_i + club_contribution.to_i + professional_tax.to_i + tds_pm.to_i + training_cost.to_i + salary_advance.to_i + additional_deduction_1.to_i + additional_deduction_2.to_i + additional_deduction_3.to_i + notice_period_amount.to_i)
  end

  def ctc
    (employee_master.ctc.to_f).round #/12
  end
  
  def tds_cal
    (1000/30.9*30).round
  end
  
  def self.get_tds_pm
    get_tds = Payslip.where(:generated_date => 3.months.ago..Time.now).select(%q{status , EXTRACT(month from generated_date)  as month, EXTRACT(year from generated_date) as year, sum(tds_pm) as tds_paid, round(sum(tds_pm/30.9*30)) as tds_calculation, round(sum((tds_pm/30.9*30)*0.03)) as education_cess }).group('status , month , year')
    get_tds
  end
  
  def self.get_quarter
    date = Date.today.beginning_of_quarter.month-3
    p "date"
    p date
  end
  
  def edu
    (tds_cal*0.03).round
  end
  def net_total
    (total_earnings - total_deductions)
  end

  def pdf
    @pdf ||= PayslipPdf.new(PayslipDecorator.decorate(self))
    @pdf.payslip
    @pdf
  end
  
  def save_payslip
    ActiveRecord::Base.transaction do
      begin
        self.save!
        post_payslip_creation_actions
      rescue Exception => e
        raise ActiveRecord::Rollback
        return false
      end
    end
    true
  end

  def post_payslip_creation_actions
    make_binus_payment_entry
    make_additional_fields_label_entry
  end

  def mark_as_pending
    self.status = "pending"
  end
  
  def approved?
    self.status == "approved"
  end
  
  private

  def make_binus_payment_entry
    bonus = EmployeeNewPayslip.new(self.employee_master, self.generated_date).bonus_payment.round
    EmployerContribution.create!({:payslip_id => self.id, :pf => self.pf, :bonus_payment => bonus, :generated_date => self.generated_date, :employee_master_id => self.employee_master.id})
  end
  
  def make_additional_fields_label_entry
    PayslipAdditionalFieldsLabel.new do |payslip_label|
      payslip_label.payslip = self
      (1..3).each do |index|
        payslip_label.send("additional_allowance_#{index}=", self.send("additional_allowance_#{index}_label"))
        payslip_label.send("additional_deduction_#{index}=", self.send("additional_deduction_#{index}_label"))
      end
    end.save
  end

end
