class PayslipsController < ApplicationController
  before_action :load_employee_master, :except => [:new_payslips, :create_payslips]
  load_resource :only => [:show, :update, :edit]
  authorize_resource

  def new
    @payslip = EmployeeNewPayslip.new(@employee_master, Date.today).payslip
  end

  def create
    @payslip = Payslip.new(payslip_params)
    @payslip.status = "generated"
    respond_to do |format|
      if @payslip.save
        format.html { redirect_to employee_master_payslip_path(@employee_master, @payslip), notice: 'Payslip Succesfulyy generated' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def new_payslips
    respond_to do |format|
      format.json do
        page = params[:page].present? ? params[:page] : 1
        employees = EmployeeMaster.having_designation(params[:designation_id]).paginate(:page => page)
        render :json => JsonPagination.pagination_entries(employees).merge!(payslips: PayslipCreationService.new_payslip_attributes_for_employees(employees, Date.today))
      end
      format.html{}
    end
    
  end

  def create_payslips
    respond_to do |format|
      format.json do
        p "=======================>>"
        p params[:payslips]
      end
      format.html{}
    end

  end

  private
  
  def load_employee_master
    @employee_master = EmployeeMaster.find(params[:employee_master_id])
  end

  def payslip_params
    PayslipCreationService.payslip_params(params.require(:payslip))
  end

end
