class EmployeeLeave < ActiveRecord::Base
  belongs_to :employee_master

  scope :in_the_month, lambda{|month| where("to_char(entered_date, 'Mon') = ?", month[0..2])}
  scope :in_the_year, lambda{|year| where("to_char(entered_date, 'YYYY') = ?", year)}


  
end
