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

  def fin_year_from
    @fin_year_from
  end

  def fin_year_to
    fin_year_to
  end

end
