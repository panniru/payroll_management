class LeaveEncashment < ActiveRecord::Base

  scope :belongs_to_employee , lambda{|employee| where(:employee_master_id => employee)}
  scope :in_the_year, lambda{|year| where("to_char(date, 'YYYY') = ?", year)}
  scope :employee_leave_encashments, lambda{|employee, year| select(:no_of_leaves_to_be_encashed).belongs_to_employee(employee).in_the_year(year)}
  scope :generated_after, lambda{|date| where("generated_date > ?", date)}
  
end
