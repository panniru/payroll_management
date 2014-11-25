class EmployeeLeavesController < ApplicationController

  def index
    page = params[:page].present? ? params[:page] : 1
    @employee_leaves = EmployeeLeave.all.order("code").paginate(:page => page)
  end

  def create
    @employee_leaves = EmployeeLeave.new(employee_leave_params)
    if @employee_leaves.save
      flash.now[:success] = I18n.t :success, :scope => [:employee_leave, :create]
      render "index"
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:employee_leave, :create]
      render "new"
    end
  end

  def upload
    @employee_leave_uploader = EmployeeLeaveUploader.new(params[:employee_leave_uploader])
    if @employee_leave_uploader.save
      flash[:success] = "Employees Successfully uploaded"
      redirect_to employee_leaves_path
    else
      flash[:error] = "Some problem occured while uploading.."
      render "new_upload"
    end
  end

  def new_upload
    @employee_leave_uploader = EmployeeLeaveUploader.new
    respond_to do |format|
      format.html { render "new_upload"}
      format.xlsx { send_data @employee_leave_uploader.xls_template, :filename=>"payroll_employee_sample.xlsx"}
    end
  end

  def export
    require 'spreadsheet'
    Spreadsheet.client_encoding = 'UTF-8'
    employee_leave = Spreadsheet::Workbook.new
    sheet1 = employee_leave.create_worksheet :name => 'Sheet1'
    sheet2 = employee_leave.create_worksheet :name => 'Sheet2'
    
    sheet2.row(0).push "Employee Id"
    sheet2.row(0).push "No of leaves to be encashed" 
    sheet2.row(0).push "Year " 
    sheet1.row(0).push "Code"
    sheet1.row(0).push "Days Worked"
    sheet1.row(0).push "Working Days"
    sheet1.row(0).push "Sl"
    sheet1.row(0).push "Cl"
    sheet1.row(0).push "Pl"
    sheet1.row(0).push "Lop"
    
    spreadsheet = StringIO.new
    employee_leave.write spreadsheet
    file = "payroll_employee_sample.xlsx"
    send_data spreadsheet.string, :filename => "#{file}", :type =>  "application/vnd.ms-excel"
  end

  
  def show
    @employee_leave_uploader = EmployeeLeaveUploader.new
    respond_to do |format|
      format.html { render "new_upload"}
      format.xlsx { send_data @employee_leave_uploader.xls_template, :filename=>"payroll_employee_sample.xlsx"}
    end
  end
  
  def edit
    @employee_leave = EmployeeLeave.find(params[:id])
  end

  def update
    @employee_leave = EmployeeLeave.find(params[:id])
    if @employee_leave.update(employee_leave_params)
      flash[:success] = I18n.t :success, :scope => [:employee_leave, :update]
      redirect_to employee_leaves_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:employee_leave, :update]
      render "edit"
    end
  end
  
  def get_leaves
    respond_to do |format|
      @employee_leaves = EmployeeLeave.all
      format.json do
        leaves= @employee_leaves.map do |field|
          { employee_master_id: field.employee_master_id, lop: field.lop, month: field.month, days_worked: field.days_worked, working_days: field.working_days, code: field.code , sl: field.sl , cl: field.cl , pl: field.pl}
        end
        render :json => leaves
      end
      format.pdf do
        render :pdf => "EmployeeLeaves",
        :formats => [:pdf, :haml],
        :page_size => 'A4',
        :margin => {:top => '8mm',
          :bottom => '8mm',
          :left => '10mm',
          :right => '10mm'}
      end
    end
  end
  
 
  private
  def employee_leave_params
    params.require(:employee_leave).permit(:employee_master_id , :lop , :month , :days_worked, :working_days , :code , :sl , :pl , :cl)
  end
end
