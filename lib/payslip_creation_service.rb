class PayslipCreationService
  class << self
    def new_payslip_attributes_for_employees(employees, date)
      employees.map do |emp|
        payslip = EmployeeNewPayslip.new(emp, date).payslip
        payslip.attributes.merge!({employee_master_code: emp.code, employee_master_name: emp.name}).except(:created_at, :updated_at)
      end
    end

    def create_payslips(params)
      payslips = params.map do |param|
        Payslip.new(payslip_params(param))
      end
      if payslips.map(&:valid?).all?
        payslips.map(&:save)
      else
        
      end
    end


    def payslip_params(params)
      params.permit(:employee_master_id, :generated_date, :basic, :hra, :conveyance_allowance, :city_compensatory_allowance, :special_allowance, :loyalty_allowance, :medical_allowance, :arrears_of_salary, :incentive_payment, :loyalty_deposit, :grade_allowance, :leave_settlement, :performance_bonus, :additional_allowance_1, :additional_allowance_2, :additional_allowance_3, :pf, :club_contribution, :proffesional_tax, :tds_pm, :training_cost, :salary_advance, :additional_deduction_1, :additional_deduction_2, :additional_deduction_3, :status)
  end

  end
end
