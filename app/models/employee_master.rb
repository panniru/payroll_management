WillPaginate.per_page = 5
class EmployeeMaster < ActiveRecord::Base
  validates :name, :presence => true
  validates :gender, :presence => true
  validates :code, :uniqueness => true, :presence => true 
  validates :pan, :uniqueness => true, allow_blank: true
  validates :ctc, :presence => true , numericality: { only_integer: true }
  attr_accessor :department_name
  attr_accessor :designation_name

  belongs_to :department_master
  belongs_to :designation_master
  has_many :employee_advance_payments
  has_many :employee_leaves, :class_name => "EmployeeLeave"

  scope :having_designation, lambda{|design_id| where(:designation_master_id => design_id)}

  def save_employee
    ActiveRecord::Base.transaction do
      begin
        self.department_master = department_from_params
        self.designation_master = designation_from_params
        self.save
      rescue Exception => e
        raise ActiveRecord::Rollback
        return false
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
end
