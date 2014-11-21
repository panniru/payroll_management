class EmployeeNewPayslip
  include SalaryBreakUpInitializer 
  basic_on_ctc :basic
  attr_on_basic :hra, :city_compensatory_allowance, :employer_pf_contribution, :bonus_payment, :loyalty_allowance
  attr_fixed_per_year :conveyance_allowance, :medical_allowance
  alias_method :pf, :employer_pf_contribution
  
  def initialize(employee, generation_date)
    @ctc = employee.ctc
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
        payslip.send("#{attribute}=", self.send(attribute).round) 
      end
    end
    payslip
  end

  private
  
  def salary_advance
    advs = @employee.employee_advance_payments.belongs_to_month(@generation_date.strftime("%b")).belongs_to_year(@generation_date.strftime("%Y"))
    advs.inject{|sum, adv| sum+adv.amount_in_rupees}
  end

  def leave_details
    employee_leaves = @employee.employee_leaves.in_the_month(@generation_date.strftime("%b")).in_the_year(@generation_date.strftime("%Y")).first
    if employee_leaves.present?
      @total_days = employee_leaves.working_days
      if employee_leaves.lop.present? 
        @total_days - employee_leaves.lop
      else
        @total_days
      end
    end
  end
end
