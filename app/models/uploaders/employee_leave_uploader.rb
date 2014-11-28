class EmployeeLeaveUploader
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  
  include Uploader
  SHEET1_HEADERS = ["code"  , "days_worked" , "working_days" , "lop" , "sl" , "pl" , "cl"]
  SHEET2_HEADERS = [ "code" , "no_of_leaves_to_be_encashed" ]

  def persisted?
    false
  end
  
  def initialize(params = {})
    super(params[:file])
   end

  def save
    super do |row, params={}|
      if params[:sheet_name] == "Sheet1"
        employee_leave = EmployeeLeave.new
        row_hash = row.to_hash.slice(*headers_to_show_sheet1)
        employee_leave.attributes = map_row_data_of_sheet1(row_hash)
        employee_master = EmployeeMaster.find_by(:code => employee_leave.attributes['code'])
        employee_leave.employee_master_id = employee_master.id
        employee_leave.entered_date = Date.today.to_s
        employee_leave
      elsif params[:sheet_name] == "Sheet2"
        encashment = LeaveEncashment.new
        row_hash = row.to_hash.slice(*headers_to_show_sheet2)
        encashment.attributes = map_row_data_of_sheet2(row_hash)
        employee_master = EmployeeMaster.find_by(:code => encashment.attributes['code'])
        encashment.employee_master_id = employee_master.id
        encashment.date = Date.today.to_s
        encashment
      end
    end
  end
  
  def headers_to_show_sheet1
    SHEET1_HEADERS.map(&:titleize)
  end
  def headers_to_show_sheet2
    SHEET2_HEADERS.map(&:titleize)
  end
   
   def map_row_data_of_sheet1(row_hash)
     SHEET1_HEADERS.map{|key| [key, row_hash[key.titleize]]}.to_h
   end
   
   
   def map_row_data_of_sheet2(row_hash)
     SHEET2_HEADERS.map{|key| [key, row_hash[key.titleize]]}.to_h
   end
   
 end
 
