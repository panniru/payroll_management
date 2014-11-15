json.array!(@employee_masters) do |employee_master|
  json.extract! employee_master, :id, :code, :name, :designation_id, :department_id, :gender, :initials, :qualification, :date_of_joining, :probation_date, :confirmation_date, :p_f_no, :bank_name, :account_number, :pan
  json.url employee_master_url(employee_master, format: :json)
end
