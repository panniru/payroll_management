class SalaryTaxCreationService
  
  class << self
    def new_salary_tax(employee, fin_year_from, fin_year_to)
      salary_tax = SalaryTax.new do |tax|
        tax.fin_year_from = fin_year_from
        tax.fin_year_to = fin_year_to
        tax.employee_master = employee
        tax.medical_insurances << MedicalInsurance.new
        tax.medical_bills << MedicalBill.new
        tax.savings << Saving.new
      end
    end
  end

  def initialize(employee_master, params)
    @employee_master = employee_master
    @salary_tax_params = params
  end

  def save
    ActiveRecord::Base.transaction do
      begin
        salary_tax = SalaryTax.new(salary_tax_params)
        if salary_tax.save!
          save_medicall_bills(salary_tax)
          save_medicall_insurances(salary_tax)
          save_savings(salary_tax)
        else
          raise ActiveRecord::Rollback
          return false
        end
      # rescue Exception => e
      #   raise ActiveRecord::Rollback
      #   return false
      end
    end
  end

  def save_medicall_bills(salary_tax)
    bills = @salary_tax_params[:medical_bills].map do |m_b_params|
      MedicalBill.new(medicall_bill_params(m_b_params)) do |bill|
        bill.employee_master = @employee_master
        bill.salary_tax = salary_tax
      end
    end
    if bills.map(&:valid?).all?
      bills.map(&:save)
    else
      raise ActiveRecord::Rollback
      return false
    end
    true
  end

  def save_medicall_insurances(salary_tax)
    insurances = @salary_tax_params[:medical_bills].map do |m_i_params|
      MedicalInsurance.new(medicall_insurance_params(m_i_params)) do |insurance|
        insurance.employee_master = @employee_master
        insurance.salary_tax = salary_tax
      end
    end
    if insurances.map(&:valid?).all?
      insurances.map(&:save)
    else
      raise ActiveRecord::Rollback
      return false
    end
    true
  end

  def save_savings(salary_tax)
    savings = @salary_tax_params[:savings].map do |s_params|
      Saving.new(saving_params(s_params)) do |saving|
        saving.employee_master = @employee_master
        saving.salary_tax = salary_tax
      end
    end
    if savings.map(&:valid?).all?
      savings.map(&:save)
    else
      raise ActiveRecord::Rollback
      return false
    end
    true
  end

    
  def salary_tax_params
    @salary_tax_params.permit(:employee_master_id, :financial_year, :rent_paid, :rent_per_month, :rent_receipt, :standard_deduction, :home_loan_amount, :rent_received, :other_tax, :total_tax_projection, :tax_paid, :educational_cess, :surcharge, :atg)
  end

  def medicall_bill_params(params)
    params.permit(:employee_master_id, :salary_tax_id, :amount, :bill_no, :bill_date)
  end

  def medicall_insurance_params(params)
    params.permit(:employee_master_id, :salary_tax_id, :amount, :bill_no, :bill_date, :parent_included, :parent_senior_citizen)
  end

  def saving_params(params)
    params.permit(:employee_master_id, :salary_tax_id, :saving_type, :amount, :bill_no, :bill_date)
  end



  
end
