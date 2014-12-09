class PfStatementDecorator < ApplicationDecorator
  delegate_all

  def member_id
    employee_master.code
  end

  def member_name
    employee_master.name
  end
  
  def fathers_husbands_name	
    employee_master.father_or_husband_name
  end

  def relation
    employee_master.relation
  end

  def emp_dob
    employee_master.date_of_birth
  end

  def emp_gender
    employee_master.gender
  end

  def doj_epf
    payslip.generated_date.strftime("%m") == employee_master.date_of_joining.strftime("%m") ? employee_master.date_of_joining : nil
  end

  def doj_eps
    doj_epf
  end

  def doe_epf
    employee_master.resignation_date.present? ? (payslip.generated_date.strftime("%m") == employee_master.resignation_date.strftime("%m") ? employee_master.resignation_date : nil) : nil
  end

  def doe_eps
    doe_epf
  end

  def r
    employee_master.reason_for_resignation
  end

end
