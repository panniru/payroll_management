class SalaryBreakUpCreator
  include SalaryBreakUpInitializer 
  basic_on_ctc :basic
  attr_on_basic :hra, :city_compensatory_allowance, :employer_pf_contribution, :bonus_payment, :loyalty_allowance
  attr_fixed_per_year :conveyance_allowance, :medical_allowance
  #private_class_method :new

  EARNINGS = ["basic", "hra", "conveyance_allowance", "city_compensatory_allowance", "medical_allowance", "special_allowance", "loyalty_allowance"] 
  DEDUCTIONS = ["employer_pf_contribution", "bonus_payment"]
  BREAK_UPS = EARNINGS + DEDUCTIONS + ["grade_allowance", "incentive_payment"]
  BREAK_UP_FORUMULA_DESC = {
    :basic => "% of CTC",
    :hra => "% of Basic", 
    :conveyance_allowance => "per Year", 
    :city_compensatory_allowance => "% of Basic", 
    :medical_allowance => "per Year", 
    :special_allowance => "Balancing Amount", 
    :employer_pf_contribution => "% of Basic", 
    :bonus_payment => "% of Basic",
    :loyalty_allowance => "% of Basic pay after the complation of 3 years of continuous service from probation"
  }

  def initialize(ctc)
    @ctc = ctc
  end


  # def self.get_instance(ctc)
  #   new(ctc)
  # end
  

  def to_h
    {
      earnings: EARNINGS.map{|component| salary_break_up_entity(component)},
      deductions: DEDUCTIONS.map{|component| salary_break_up_entity(component)}
    }
  end

  def salary_break_up_entity(component)
    {
      component: component.titleize,
      criteria: "#{component_criterias[component.to_sym]} #{BREAK_UP_FORUMULA_DESC[component.to_sym]}",
      amount_per_month: (send(component.to_sym)).round,
      amount_per_year: (send(component.to_sym)*12).round
    }
  end

  private

  # def initialize(ctc)
  #   @ctc = ctc
  # end
  
end
