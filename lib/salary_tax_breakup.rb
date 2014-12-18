class SalaryTaxBreakup
  include SalaryTaxComponents

  def self.income_tax_on_amount(amount)
    tax  = 0
    SalaryTax.tax_limits[:income_tax].each do |key, val|
      break if amount <= 0
      if val["to"].present?
        range = val["to"] - val["from"]
        if amount >= range
          tax = (tax + range*(val["tax"].to_f/100))
        else
          tax = (tax + amount*(val["tax"].to_f/100))
        end
        amount = amount - range
      else
        tax = (tax + amount*(val["tax"].to_f/100))
        amount = amount - val["from"]
      end
    end
    tax.round
  end

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
