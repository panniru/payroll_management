class SalaryTax < ActiveRecord::Base
  belongs_to :employee_master
  has_many :medical_insurances
  has_many :medical_bills
  has_many :savings
  include SalaryTaxComponents
  include SalaryTaxDecorators
  
  #attr_accessor :basic, :hra, :conveyance_allowance, :city_compensatory_allowance, :special_allowance, :loyalty_allowance, :leave_settlement, :medical_allowance, :other_payment, :pf, :tds_pm, :total_Earnings, :professional_tax
  
  scope :in_the_financial_year, lambda{|fin_year_from, fin_year_to| where(:financial_year_from => fin_year_from, :financial_year_to => fin_year_to)}

  def claimed_medical_bill
    medical_bills.inject(0){|sum, bill| sum+bill.amount.to_i}
  end

  def medical_insurances_total
    medical_insurances.inject(0){|sum, insurance| sum+insurance.amount.to_i}
  end

  def savings_total
    savings.inject(0){|sum, saving| sum+saving.amount.to_i}
  end


  def title
    "Salary Tax #{financial_year_from.strftime("%Y")} - #{financial_year_to.strftime("%Y")[2..3]}"
  end
  
  class << self   
    
    def tax_limits
      {
        mediclaim_employee_limit: rule_engine.value("salary_tax", "mediclaim_employee_limit"),
        mediclaim_parent_limit: rule_engine.value("salary_tax", "mediclaim_parent_limit"),
        mediclaim_parent_senior_citizen_limit: rule_engine.value("salary_tax", "mediclaim_parent_senior_citizen_limit"),
        savings_up_to: rule_engine.value("salary_tax", "savings_up_to"),
        income_tax: rule_engine.value("salary_tax", "income_tax"),
        educational_cess: rule_engine.value("salary_tax", "educational_cess"),
        maintanance_on_rent_received: rule_engine.value("salary_tax", "maintanance_on_rent_received")
      }
    end
    
    def rule_engine
      @@rule_engine ||= RuleEngine.new
    end
  end

  def as_json(options)
    super(:include =>  [:savings, :medical_insurances, :medical_bills], :methods => [:basic, :hra, :conveyance_allowance, :city_compensatory_allowance, :special_allowance, :loyalty_allowance, :leave_settlement, :medical_allowance, :other_payment, :pf, :tds_pm, :total_Earnings, :professional_tax, :medical_insurances_total, :savings_total, :claimed_medical_bill, :rent_paid, :rent_received])
  end

end
