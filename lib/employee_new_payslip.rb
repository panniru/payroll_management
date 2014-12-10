class EmployeeNewPayslip
  include SalaryBreakUpInitializer 
  basic_on_ctc :basic
  attr_on_basic :hra, :city_compensatory_allowance, :employer_pf_contribution, :bonus_payment #, :loyalty_allowance
  attr_fixed_per_year :conveyance_allowance, :medical_allowance
  alias_method :pf, :employer_pf_contribution
  
  def initialize(employee, generation_date)
    @ctc = employee.ctc
    @basic = employee.basic
    @employee = employee
    @generation_date = generation_date
    # @total_days = total_days
    # @worked_days = worked_days
  end

  def payslip
    leave_details
    payslip = Payslip.new
    payslip.employee_master_id = @employee.id
    payslip.generated_date = @generation_date
    payslip.attributes.each do |attribute, value|
      if self.respond_to? attribute.to_sym and payslip.respond_to? "#{attribute}="
        payslip.send("#{attribute}=", self.send(attribute).try(:round)) 
      end
    end
    inject_monthly_input_components_from_prvious_month(payslip)
    payslip
  end

  # menthod_name should be same as payslip attribute salary_advance
  def salary_advance
    advs = @employee.employee_advance_payments.belongs_to_month(@generation_date.strftime("%b")).belongs_to_year(@generation_date.strftime("%Y"))
    advs.inject(0){|sum, adv| sum+adv.amount_in_rupees}
  end

  # menthod_name should be same as payslip attribute salary_advance
  def leave_settlement
    if @employee.eligible_for_leave_settlement?(@generation_date)
      leaves_to_encash = LeaveEncashment.employee_leave_encashments(@employee, @generation_date.year.to_s).first.try(:no_of_leaves_to_be_encashed).to_i
      ((basic.to_f/@generation_date.end_of_month.day) * leaves_to_encash)
    end
  end

  # menthod_name should be same as payslip attribute loyalti_allowance
  def loyalty_allowance
    if @employee.eligible_for_loyality_allowance?(@generation_date)
      (((component_criterias[:loyalty_allowance]/100)*basic) * eligibility_fraction)
    end
  end
  
  # menthod_name should be same as payslip attribute annual_bonus
  def annual_bonus
    if @employee.eligible_for_annual_bonus_payment?(@generation_date)
      last_annual_bonus_paid_on = @employee.last_annual_bonus_paid_on
      unless last_annual_bonus_paid_on.present?
        last_annual_bonus_paid_on = Date.new(@generation_date.year-1, @employee.rule_engine.value(:payslip, :bonus_payment_month)+1, 1)
      end
      EmployerContributions.belongs_to_employee(@employee).generated_after(last_annual_bonus_paid_on).inject(0){|sum, contrib| sum+contrib.bonus_payment}
    end
  end

  private

  def leave_details
    employee_leaves = @employee.leaves_taken_in_the_month(@generation_date)
    if employee_leaves.present?
      @total_days = employee_leaves.working_days
      if employee_leaves.lop.present? 
        @worked_days = @total_days - employee_leaves.lop
      else
        @total_days
      end
    end
  end

  def inject_monthly_input_components_from_prvious_month(payslip)
    old_payslip = @employee.payslips.in_the_current_month(@generation_date.last_month).first
    if old_payslip.present?
      DefaultAllowanceDeduction.valid_attributes.each do |key|
        if payslip.respond_to? key
          payslip.send("#{key}=", old_payslip.send(key))
        end
      end
    else
      inject_monthly_input_components_from_defaults(payslip)
    end
  end

  def inject_monthly_input_components_from_defaults(payslip)
    dafault_values = DefaultAllowanceDeduction.belongs_to_employee(@employee).first
    if dafault_values.present?
      DefaultAllowanceDeduction.valid_attributes.each do |key|
        if payslip.respond_to? key
          payslip.send("#{key}=", dafault_values.send(key))
        end
      end
    end
  end
end
