class EmployeeMasterUploader
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include Uploader
  HEADERS = ["code", "name", "designation_name", "department_name", "father_or_husband_name", "relation", "gender", "date_of_birth", "email","initials", "qualification", "date_of_joining", "probation_date", "confirmation_date", "resignation_date", "reason_for_resignation", "p_f_no", "unusual_pf","bank_name", "account_number", "pan", "ctc"]
  
  def persisted?
    false
  end

  def initialize(params = {})
    super(params[:file])
  end

  def save
    super do |row, params={}|
      employee_master = EmployeeMaster.new
      row_hash = row.to_hash.slice(*headers_to_show)
      employee_master.attributes = map_row_data(row_hash)
      employee_master.designation_master = employee_master.designation_from_params
      employee_master.department_master = employee_master.department_from_params
      employee_master.ctc = employee_master.ctc.to_i
      employee_master.account_number = employee_master.account_number.to_i.to_s
      employee_master
    end
  end

  def headers_to_show
    HEADERS.map(&:titleize)
  end

  def map_row_data(row_hash)
    HEADERS.map{|key| [key, row_hash[key.titleize]]}.to_h
  end

  def xls_template(options = {})
    CSV.generate(options) do |csv|
      csv << headers_to_show
    end
  end

end
