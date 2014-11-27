class DefaultAllowanceDeduction < ActiveRecord::Base
  belongs_to :employee_master

  def self.valid_attributes
    @@keys ||= self.new.attributes.keys
    @@keys.delete("id")
    @@keys.delete("employee_master_id")
    @@keys.delete("created_at")
    @@keys.delete("updated_at")
    @@keys
  end

  scope :belongs_to_employee, lambda{|employee_master| where(:employee_master_id => employee_master)}
end
