WillPaginate.per_page = 30
class EmployeeMaster < ActiveRecord::Base

  validates :name, :presence => true
  validates :gender, :presence => true
  validates :designation_master_id, :presence => true
  validates :department_master_id, :presence => true
  validates :code, :uniqueness => true, :presence => true 
  validates :pan, :uniqueness => true, allow_blank: true
  validates :ctc, :presence => true , numericality: { only_integer: true }
  validates :basic, :presence => true , numericality: { only_integer: true }
  
  validate :date_of_birth_cannot_be_in_past, :date_of_joining_cannot_be_in_past, :date_of_resignation_cannot_be_less_than_joining,
  :date_of_probation_cannot_be_less_than_joining 

  attr_accessor :department_name
  attr_accessor :designation_name
  
  belongs_to :department_master
  belongs_to :designation_master
  has_many :employee_advance_payments
  has_many :employee_leaves, :class_name => "EmployeeLeave"
  has_many :payslips
  has_many :salary_taxes
  has_many :form24s
  
  before_save :set_special_allowance

  scope :in_the_current_month, lambda{|date| in_the_month(date.strftime("%F"))}
  scope :resignation_between, lambda{|from_date, to_date| where(:resignation_date => (from_date..to_date))}
  scope :joined_between, lambda{|from_date, to_date| where(:date_of_joining => (from_date..to_date))}
  scope :managed_by, (lambda do |user| 
    if user.manager? or user.director?
      all
    else
      where(:designation_master_id => DesignationMaster.select(:id).managed_by(user))
    end
  end)

  scope :having_designation, lambda{|design_id| where(:designation_master_id => design_id)}
  scope :has_no_pay_slips_in_the_month, lambda{|date| where("id not in (?)", Payslip.select(:employee_master_id).in_the_current_month(date))}
  scope :not_resigned_on_or_before_month_begin, lambda{|date| where("resignation_date IS NULL OR resignation_date >= ?", date.at_beginning_of_month)}
  scope :foreign_employees, lambda{ where(:status => "foreign")}
  scope :regular_employees, lambda{ where(:status => "regular")}
  
  def save_employee
    ActiveRecord::Base.transaction do
      begin
        self.department_master = department_from_params
        self.designation_master = designation_from_params
        if self.save
          return true
        else
          raise ActiveRecord::Rollback
          return false
        end
      end
    end
  end

  def department_from_params
    dept = nil
    if department_name.present? && department_master_id.blank?
      dept = DepartmentMaster.where(:name => department_name).first
      if not dept.present?
        dept = DepartmentMaster.create({:name => department_name})
      end
    elsif department_master_id.present?
      dept = DepartmentMaster.find(department_master_id)
    end
    dept
  end

  def designation_from_params
    designation = nil
    if designation_name.present? && designation_master_id.blank?
      designation = DesignationMaster.where(:name => designation_name).first
      if not designation.present?
        designation = DesignationMaster.create({:name => designation_name})
      end
    elsif designation_master_id.present?
      designation = DesignationMaster.find(designation_master_id)
    end
    designation
  end
 

  def eligible_for_loyality_allowance?(date)
    date_before_3_years = Date.new(date.year-3, date.month, date.day)
    (probation_date.present? and probation_date <= date_before_3_years)
    # if probation_date.present? and probation_date < date_before_3_years
    #   if last_loyality_allowance_found_at.present? and last_loyality_allowance_found_at <= date_before_3_years
    #     return true
    #   elsif probation_date.present? and probation_date <= date_before_3_years
    #     return true
    #   else
    #     return false
    #   end
    # end
  end

  def last_loyality_allowance_found_at
    payslip = self.payslips.select(:generated_date).having_loyality_allowance.order("generated_date DESC").first
    if payslip.present?
      return payslip.generated_date
    else
      nil
    end
  end

  def last_annual_bonus_paid_on
    payslip = self.payslips.select(:generated_date).having_annual_bonus.order("generated_date DESC").first
    if payslip.present?
      return payslip.generated_date
    else
      nil
    end
  end


  def eligible_for_leave_settlement?(date)
    date.month == rule_engine.value(:payslip, :leave_settlement_month)
  end

  def eligible_for_annual_bonus_payment?(date)
    date.month == rule_engine.value(:payslip, :bonus_payment_month)
  end

  def eligible_for_labour_welfare_fund?(date)
    date.month == rule_engine.value(:payslip, :labour_welfare_fund_month)
  end

  def rule_engine
    @rule_engine ||= RuleEngine.new
  end

  # grant(:find) { |user, model, action| model.readable_by_user? user }
  # grant(:create, :update, :destroy) { |user, model, action| model.editable_by_user? user }

  def readable_by_user? user
    if user.manager? or user.director?
      true
    else
      self.designation_master.managed_by == user.role_id
    end
  end
  
  def editable_by_user? user
    readable_by_user? user
  end

  def leaves_taken_in_the_month(date)
    employee_leaves.in_the_month(date.strftime("%b")).in_the_year(date.strftime("%Y")).first
  end

  def eligible_for_payslip?(date)
    (resignation_date.present? and resignation_date < date.at_beginning_of_month) ? false : true
  end

  private

  def set_special_allowance
    if self.changed_attributes.include? "ctc" or self.changed_attributes.include? "basic"
      self.special_allowance = SalaryBreakUpCreator.new(ctc, basic, probation_date, Date.today, designation_master.try(:name)).special_allowance.round
    end 
  end

  def date_of_birth_cannot_be_in_past
    errors.add(:date_of_birth, "can't be in the future") if date_of_birth.present? and date_of_birth > Date.today
  end

  def date_of_joining_cannot_be_in_past
    errors.add(:date_of_joining, "can't be in the future") if date_of_joining.present? and date_of_joining > Date.today
  end

  def date_of_resignation_cannot_be_less_than_joining
    errors.add(:resignation_date, "can't be less than joining date") if resignation_date.present? and date_of_joining.present? and resignation_date < date_of_joining
  end

  def date_of_probation_cannot_be_less_than_joining 
    errors.add(:probation_date, "can't be less than joining date") if probation_date.present? and date_of_joining.present? and probation_date < date_of_joining
  end

end
