class FinancialYearCalculator
  
  def initialize(date)
    @date = date
  end

  def financial_year_from
    if current_month > 3
      Date.new(current_year, 04, 1)
    else
      Date.new(current_year-1, 04, 1)
    end
  end

  def financial_year_to
    if current_month > 3
      Date.new(current_year+1, 03, 31)
    else
      Date.new(current_year, 03, 31)
    end
  end

  def quarter_1_range
    (financial_year_from.beginning_of_quarter..financial_year_from.end_of_quarter)
  end


  def quarter_2_range
    quarter_2 = quarter_1_range.first.next_quarter
    (quarter_2.beginning_of_quarter..quarter_2.end_of_quarter)
  end

  def quarter_3_range
    quarter_3 = quarter_2_range.first.next_quarter
    (quarter_3.beginning_of_quarter..quarter_3.end_of_quarter)
  end

  def quarter_4_range
    quarter_4 = quarter_3_range.first.next_quarter
    (quarter_4.beginning_of_quarter..quarter_4.end_of_quarter)
  end

  def current_quarter_num
  end
  

  private
  
  def current_month
    @date.month
  end

  def current_year
    @date.year
  end
  
end

