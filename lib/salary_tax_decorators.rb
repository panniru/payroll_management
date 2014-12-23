module SalaryTaxDecorators

  def educational_cess
    (tax_projected * (tax_limits[:educational_cess].to_f/100)).round
  end
  
  def surcharge
    0
  end

  def tax_projected
    SalaryTaxBreakup.income_tax_on_amount(total_amount_to_tax)
  end

  def rent_per_year
    rent_per_month.to_i * 12
  end
  
  def rent_paid
    return 0 if rent_per_year <= 0
    rent_excess_salary = (rent_per_year - (basic * 0.1)).abs
    [rent_excess_salary, hra].min
  end

  def rent_recieved_per_year
    (rent_received_per_month.to_i * 12)
  end

  def rent_received
    maintanace_cost = tax_limits[:maintanance_on_rent_received]
    rent_recieved_per_year - (rent_recieved_per_year * maintanace_cost.to_f/100)
  end

  def total_deductions
    (rent_paid + home_loan_amount.to_i  + standard_deduction.to_i + medical_insurances_total + claimed_medical_bill + savings_total + professional_tax.to_i + conveyance_allowance + atg.to_i - rent_received)
  end
  
  def total_amount_to_tax
    total_earnings - total_deductions
  end

  def net_tax
    educational_cess + surcharge + tax_projected
  end

  def balance_tax
    net_tax - tax_paid.to_i
  end

  def tax_paid
    existed_payslips.inject(0){|sum, payslip| sum + payslip.tds_pm}.round
  end
  
  def total_income
    total_earnings
  end

  private

  def tax_limits
    @tax_limits ||= SalaryTax.tax_limits
  end

end
