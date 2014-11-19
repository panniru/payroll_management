class EmployeeLeaveUploader
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include Uploader
  HEADERS = ["code"  , "total_days" , "working_days" , "lop" ]

  def persisted?
    false
  end
  
  def initialize(params = {})
    super(params[:file])
   end

  def save
    super do |row|
      employee_leave = EmployeeLeave.new
      row_hash = row.to_hash.slice(*headers_to_show)
      employee_leave.attributes = map_row_data(row_hash)
      employee_master = EmployeeMaster.find_by(:code => employee_leave.attributes['code'])
      employee_leave.employee_master_id = employee_master.id
      employee_leave.entered_date = Date.today.to_s
      employee_leave
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
