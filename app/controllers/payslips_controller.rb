class PayslipsController < ApplicationController
  before_action :load_employee_master, :except => [:new_payslips, :create_payslips, :approve_payslips, :index, :email_payslips, :new_email_payslips, :bank_advice]
  load_resource :only => [:show, :update, :edit, :mail]
  authorize_resource

  def show
    @payslip = PayslipDecorator.decorate(@payslip)
    respond_to do |format|
      format.html do
      end
      format.pdf do 
        send_data @payslip.pdf.render, type: "application/pdf", disposition: "inline"
      end
    end
  end
  
  def new
    if @employee_master.eligible_for_payslip? (session[:transaction_date])
      @payslip = @employee_master.payslips.in_the_current_month(session[:transaction_date]).first
      unless @payslip.present?
        @payslip = EmployeeNewPayslip.new(@employee_master, session[:transaction_date]).payslip
        render "new"
      else
        flash[:alert] = "Payslip of #{@employee_master.name} for the month <b>#{session[:transaction_date].strftime('%b')} #{session[:transaction_date].strftime('%Y')}</b>  has been generated and it exists <a href='/employee_masters/#{@employee_master.id}/payslips/#{@payslip.id}'> here</a>"
        redirect_to payslips_path
      end
    else
      flash[:alert] = "Employee has been resigned. Not eligible to create payslip"
      redirect_to @employee_master
    end
  end

  def create
    @payslip = Payslip.new(payslip_params)
    @payslip.mark_as_pending
    #@payslip.generated_date = session[:transaction_date]
    respond_to do |format|
      if @payslip.save_payslip
        format.html { redirect_to employee_master_payslip_path(@employee_master, @payslip), notice: 'Payslip Succesfulyy generated' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    @payslip.assign_attributes(payslip_params)
    @payslip.mark_as_pending
    #@payslip.generated_date = session[:transaction_date]
    respond_to do |format|
      if @payslip.save_payslip
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
        employees = EmployeeMaster.managed_by(current_user).having_designation(params[:designation_id]).not_resigned_on_or_before_month_begin(session[:transaction_date]).paginate(:page => page).has_no_pay_slips_in_the_month(session[:transaction_date])
        render :json => JsonPagination.pagination_entries(employees).merge!(payslips: PayslipCreationService.new_payslip_attributes_for_employees(employees, session[:transaction_date]))
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
    @month = params[:month]
    @year = params[:year]
    @employee_master = EmployeeMaster.find(params[:employee_master_id]) if params[:origin].present? and params[:origin] == 'employee' and params[:employee_master_id].present?
    respond_to do |format|
      page = params[:page].present? ? params[:page] : 1
      @payslips = Payslip.payslips_on_params(params, current_user)
      @payslips= @payslips.paginate(:page => page)
      format.html{}
      format.json do
        data = @payslips.map{|p| {:id => p.id, :employee_master_id => p.employee_master_id, :net_total => p.net_total, :ctc => p.ctc, :employee_name => p.employee_master.name, :designation => p.employee_master.designation_master.name, :status => p.status, :employee_code => p.employee_master.code}}
        render :json => JsonPagination.pagination_entries(@payslips).merge!(payslips: data)
      end
      format.pdf do
        render :pdf => "payslip_#{@month}_#{@year}",
        :formats => [:pdf],
        :page_size => 'A4',
        :orientation => 'Landscape'
      end
    end
  end

  def approve_payslips
    respond_to do |format|
      format.json do
        status = params[:payslips].map do |param|
          payslip = Payslip.find(param[:id])
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
  
  def new_email_payslips
  end

  def email_payslips
    @month = params[:month]
    @year = params[:year]
    job_run = JobRun.matching_code(JobRun::PAYSLIP_MAILING).in_the_month(params[:month]).in_the_year(params[:year]).first
    unless job_run.present? and (job_run.scheduled? or job_run.finished?)
      mail_job = PayslipMailingJob.new(current_user, params[:month], params[:year], session[:transaction_date])
      Delayed::Job.enqueue mail_job
      result_link = "<a href=\"/job_runs/#{mail_job.job_run_id}\">here</a>"
      flash[:success] = I18n.t :success, :scope => [:job, :schedule], job: JobRun::PAYSLIP_MAILING.titleize, job_link: result_link
    else
      result_link = "<a href=\"/job_runs/#{job_run.id}\">here</a>"
      if job_run.scheduled?
        flash[:alert] = I18n.t :already_scheduled, :scope => [:job, :schedule], job: JobRun::PAYSLIP_MAILING.titleize, job_link: result_link
      elsif job_run.finished?
        flash[:alert] = I18n.t :already_finished, :scope => [:job, :schedule], job: JobRun::PAYSLIP_MAILING.titleize, job_link: result_link
      end
    end
    render "new_email_payslips"
  end
  
  def mail
    PayslipMailer.payslip(@payslip).deliver
    flash.now[:success] = "Mail Sent Successfully"
    render "show"
  end

  
  def bank_advice
    @month = params[:month]
    @year = params[:year]
    params[:status] = 'approved'
    respond_to do |format|
      @payslips = Payslip.payslips_on_params(params, current_user)
      format.pdf do
        render :pdf => "salary_payment_#{@month}_#{@year}",
        :formats => [:pdf],
        :page_size => 'A4',
        :orientation => 'Landscape'
      end
    end
  end
  
  private
  
  def load_employee_master
    @employee_master = EmployeeMaster.find(params[:employee_master_id])
    unless @employee_master.readable_by_user? current_user
      raise CanCan::AccessDenied
    end
  end

  def payslip_params
    PayslipCreationService.payslip_params(params.require(:payslip))
  end

end
