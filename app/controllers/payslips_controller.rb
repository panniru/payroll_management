class PayslipsController < ApplicationController
  before_action :load_employee_master, :except => [:new_payslips, :create_payslips, :approve_payslips, :index]
  load_resource :only => [:show, :update, :edit]
  authorize_resource

  def new
    @payslip = EmployeeNewPayslip.new(@employee_master, Date.today).payslip
  end

  def create
    @payslip = Payslip.new(payslip_params)
    @payslip.status = "pending"
    @payslip.generated_date = Date.today
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
        employees = EmployeeMaster.having_designation(params[:designation_id]).paginate(:page => page).has_no_pay_slips_in_the_month(Date.today)
        render :json => JsonPagination.pagination_entries(employees).merge!(payslips: PayslipCreationService.new_payslip_attributes_for_employees(employees, Date.today))
      end
      format.html{}
    end
    
  end

  def create_payslips
    respond_to do |format|
      format.json do
        render :json => {status: PayslipCreationService.create_payslips(params[:payslips])}
      end
      format.html{}
    end
  end

  def index
    @employee_master = EmployeeMaster.find(params[:employee_master_id]) if params[:origin].present? and params[:origin] == 'employee' and params[:employee_master_id].present?
    respond_to do |format|
      format.html{}
      format.json do
        page = params[:page].present? ? params[:page] : 1
        payslips = Payslip.payslips_on_params(params, page)
        data = payslips.map{|p| {:id => p.id, :employee_master_id => p.employee_master_id, :net_total => p.net_total, :ctc => p.ctc, :employee_name => p.employee_master.name, :designation => p.employee_master.designation_master.name, :status => p.status, :employee_code => p.employee_master.code}}
        render :json => JsonPagination.pagination_entries(payslips).merge!(payslips: data)
      end
    end
  end

  def approve_payslips
    respond_to do |format|
      format.json do
        status = params[:payslips].map do |param|
          payslip = Payslip.find(param[:id])
          p "=========="
          p param[:isChecked]
          payslip.change_status(params[:status]) if param[:isChecked].present? and param[:isChecked]
        end
        if status.all?
          render :json => {status: true}
        else
          render :json => {status: false}
        end
      end
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
