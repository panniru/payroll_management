class EmployeeAdvancePayment < ActiveRecord::Base
  validates :payment_date, :presence => true
  validates :amount_in_rupees, :presence => true, numericality: { only_integer: true }
  validates :employee_master_id, :presence => true
  
  belongs_to :employee_master
  
  scope :belongs_to_month, lambda{|month| where("to_char(payment_date, 'Mon') = ?", month[0..2])}
  scope :belongs_to_year, lambda{|year| where("to_char(payment_date, 'YYYY') = ?", year)}

  def can_edit?
    status == "generated"
  end
end
