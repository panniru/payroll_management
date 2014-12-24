class Form24 < ActiveRecord::Base
  scope :in_the_quarter, lambda{|quarter| where(:quarter => quarter)}
  scope :in_the_financial_year, lambda{|year| where(:financial_year => year)}
  
  def self.get_date
    a =  (Date.today.year-1..Date.today.year).map{|year| "#{year} - #{year+1}"}
  end
  

  def self.get_tds_pm(current_user, date)
    data = []
    regular_payslips = Payslip.select("to_char(generated_date, 'MM YYYY') as month_year, sum(tds_pm) total_tds").generated_between(date.beginning_of_quarter, date.end_of_quarter).regulars_manageable_by_user(current_user).group('month_year')
    regular_payslips.each do |payslip|
      edu_cess = payslip.total_tds * (rule_engine.value("salary_tax", "educational_cess").to_f/100)
      data << {month: payslip.month_year.split(" ")[0], year: payslip.month_year.split(" ")[1], total_tds_pm: payslip.total_tds,  educational_cess: edu_cess, total_tax_payble: (edu_cess + payslip.total_tds), status: 'regular'}
    end
    foreign_payslips = Payslip.select("to_char(generated_date, 'MM YYYY') as month, sum(tds_pm) total_tds").generated_between(date.beginning_of_quarter, date.end_of_quarter).foreigners_manageable_by_user(current_user).group('month')
    foreign_payslips.each do |payslip|
      edu_cess = payslip.total_tds * (rule_engine.value("salary_tax", "educational_cess").to_f/100)
      data << {month: payslip.month_year.split(" ")[0], year: payslip.month_year.split(" ")[1], total_tds_pm: payslip.total_tds,  educational_cess: edu_cess, total_tax_payble: (edu_cess + payslip.total_tds), status: 'foreign'}
    end
    data
  end
  
  def self.rule_engine
    @rule_engine ||= RuleEngine.new
  end
end
