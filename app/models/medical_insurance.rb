class MedicalInsurance < ActiveRecord::Base
  belongs_to :employee_master
  belongs_to :salary_tax
end
