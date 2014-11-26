class EmployerContributions < ActiveRecord::Base

  scope :belongs_to_employee , lambda{|employee| where(:employee_master_id => employee)}
  scope :generated_after, lambda{|date| where("generated_date > ?", date)}

end
