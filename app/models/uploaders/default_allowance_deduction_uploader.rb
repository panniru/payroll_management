class DefaultAllowanceDeductionUploader 
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include Uploader
  

  def persisted?
    false
  end

  def initialize(params = {})
    super(params[:file])
  end

  def save
    super do |row, params={}|
      row_hash = row.to_hash.slice(*headers_to_show)
      data_hash = map_row_data(row_hash)
      employee_master = EmployeeMaster.find_by_code(data_hash["employee_code"])
      default_allowance = DefaultAllowanceDeduction.find_by_employee_master_id(employee_master) || DefaultAllowanceDeduction.new
      data_hash.delete("employee_code")
      default_allowance.attributes = data_hash
      default_allowance.employee_master = employee_master
      default_allowance
    end
  end

  def headers_to_show
    headers.map(&:titleize)
  end

  def map_row_data(row_hash)
    headers.map{|key| [key, row_hash[key.titleize]]}.to_h
  end

  def xls_template(options = {})
    CSV.generate(options) do |csv|
      csv << headers_to_show
    end
  end

  def headers
    @headers ||= (["employee_code"] + DefaultAllowanceDeduction.valid_attributes)
  end

end
