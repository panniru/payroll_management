class EmployeeLeaveUploader
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
 
  include Uploader
  HEADERS1 = ["code"  , "days_worked" , "working_days" , "lop" , "sl" , "pl" , "cl"]
  HEADERS2 = [ "code " , "no_of_leaves_to_be_encashed" , "year"]

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
        row_hash = row.to_hash.slice(*headers_to_show)
        p "22222222222222"
        p row_hash
        employee_leave.attributes = map_row_data(row_hash)
        employee_master = EmployeeMaster.find_by(:code => employee_leave.attributes['code'])
        employee_leave.employee_master_id = employee_master.id
        employee_leave.entered_date = Date.today.to_s
        employee_leave
      elsif params[:sheet_name] == "Sheet2"
        encashment = LeaveEncashment.new
        row_hash = 
          p *headers_to_show1
          p row.to_hash.slice(*headers_to_show1)
        p "111111111111"
        p row_hash
        encashment.attributes = map_row_data1(row_hash)
        employee_master = EmployeeMaster.find_by(:code => employee_leave.attributes['code'])
        employee_leave.employee_master_id = employee_master.id
        employee
      end
    end
  end
  
  def headers_to_show
    HEADERS1.map(&:titleize)
  end
  def headers_to_show1
    HEADERS2.map(&:titleize)
  end
   
   def map_row_data(row_hash)
     HEADERS1.map{|key| [key, row_hash[key.titleize]]}.to_h
   end
   
   
   def map_row_data1(row_hash)
     HEADERS2.map{|key| [key, row_hash[key.titleize]]}.to_h
   end
   
   
   
 end
 
