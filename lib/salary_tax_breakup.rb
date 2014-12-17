class SalaryTaxBreakup
  include SalaryTaxComponents

  def initialize(employee_master, fin_year_from, fin_year_to)
    @employee_master = employee_master
    @fin_year_from = fin_year_from
    @fin_year_to = fin_year_to
  end

  def employee_master
    @employee_master
  end

  def financial_year_from
    @fin_year_from
  end

  def financial_year_to
    @fin_year_to
  end

  def payslip_components_monthly_report(component)
    payslips.map do |payslip|
      if payslip.respond_to? component.to_sym
        {
          payslip_id: payslip.id,
          month: payslip.generated_date.strftime("%b"),
          amount: payslip.send(component.to_sym)
        }
      else
        nil
      end 
    end
  end
end
