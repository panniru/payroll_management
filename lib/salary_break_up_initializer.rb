module SalaryBreakUpInitializer 
  attr_accessor :ctc
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def basic_on_ctc(param)
      define_method param.to_sym do
        ((((component_criterias[:basic]/100)*ctc)/12) * eligibility_fraction)
      end
    end
    
    def attr_on_basic(*params)
      params.each do |param|
        define_method param.to_sym do
          (((component_criterias[param.to_sym]/100)*basic) * eligibility_fraction)
        end
      end
    end

    def attr_fixed_per_year(*params)
      params.each do |param|
        define_method param.to_sym do
          ((component_criterias[param.to_sym]/12) * eligibility_fraction)
        end
      end
    end
  end

  def special_allowance
    (ctc_per_month - primary_earnings)
  end

  private
  
  def ctc_per_month
    ctc.to_f/12
  end

  def primary_earnings
    basic+hra+conveyance_allowance+ city_compensatory_allowance + medical_allowance + employer_pf_contribution + bonus_payment
  end
  
  def component_criterias
    @component_criterias ||= SalaryBreakUp.all.map{|break_up| [break_up.component_code.to_sym, break_up.criteria] }.to_h
  end

  def eligibility_fraction
    if @total_days.present? and @worked_days.present? and @total_days > 0 and @worked_days > 0
      (@worked_days.to_f/@total_days.to_f)
    else
      1
    end
  end
  
end
