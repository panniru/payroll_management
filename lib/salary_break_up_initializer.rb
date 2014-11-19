module SalaryBreakUpInitializer 
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def basic_on_ctc(param)
      define_method param.to_sym do
        ((component_criterias[:basic]/100)*@ctc)
      end
    end
    
    def attr_on_basic(*params)
      params.each do |param|
        define_method param.to_sym do
          ((component_criterias[param.to_sym]/100)*basic)
        end
      end
    end

    def attr_fixed_per_year(*params)
      params.each do |param|
        define_method param.to_sym do
          component_criterias[param.to_sym]
        end
      end
    end
  end

  def special_allowance
    (@ctc - (primary_earnings + salary_break_up_deductions))
  end

  def salary_break_up_deductions
    (employer_pf_contribution + bonus_payment)
  end
  

  private
  
  def primary_earnings
    basic+hra+conveyance_allowance+ city_compensatory_allowance + medical_allowance
  end
  
  def component_criterias
    @component_criterias ||= SalaryBreakUp.all.map{|break_up| [ break_up.component_code.to_sym, break_up.criteria] }.to_h
  end
  
end
