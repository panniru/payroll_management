class EmployeeLeavesController < ApplicationController

  def index
    @employee_leaves = EmployeeLeave.all
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

 
  private
  def employee_leave_params
    params.require(:employee_leave).permit(:employee_master_id , :lop , :month , :days_worked, :working_days , :code , :sl , :pl , :cl)
  end
end
