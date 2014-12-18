class SalaryTaxesController < ApplicationController
  before_action :load_employee_master, :except => [:tax_limits]
  load_resource :only => [:show, :update, :edit]
  authorize_resource

  def index
    @salary_taxes = @employee_master.salary_taxes
  end
  
  def new
    # @salary_tax = @employee_master.salary_taxes.in_the_financial_year(session[])
    # if 
    @salary_tax = SalaryTaxCreationService.new_salary_tax(@employee_master, session[:financial_year_from], session[:financial_year_to])
    respond_to do |format|
      format.html {}
      format.json do
        render :json => @salary_tax
      end
    end
  end

  def create
    respond_to do |format|
      format.html {
        @salary_tax = SalaryTaxCreationService.new(@employee_master, params[:salary_tax], session[:financial_year_from], session[:financial_year_to]).create
        if @salary_tax.present?
          flash[:success] = "Salary Tax has been generated succesfully"
          redirect_to employee_master_salary_tax_path(@employee_master, @salary_tax)
        else
          flash[:error] = "Salary Tax has not been generated"
          render "new"
        end
      }
      format.json do
        @salary_tax = SalaryTaxCreationService.new(@employee_master, params[:salary_tax], session[:financial_year_from], session[:financial_year_to]).create
        render :json => {:status => @salary_tax.present?, :id =>  @salary_tax.try(:id)} 
      end
    end
  end


  def update
    respond_to do |format|
      format.json do
        status = SalaryTaxCreationService.new(@employee_master, params[:salary_tax], session[:financial_year_from], session[:financial_year_to]).update(@salary_tax)
        render :json => {:status => status}
      end
    end
  end
  
  def edit
    
    respond_to do |format|
      format.html {}
      format.json do
        @salary_tax.medical_bills << MedicalBill.new if @salary_tax.medical_bills.empty?
        @salary_tax.savings << Saving.new if @salary_tax.savings.empty?
        @salary_tax.medical_insurances << MedicalInsurance.new if @salary_tax.medical_insurances.empty?
        render :json => @salary_tax
      end
    end
  end
  
  def tax_limits
    respond_to do |format|
      format.json do
        render :json => SalaryTax.tax_limits
      end
    end
  end

  def component_monthly_report
    respond_to do |format|
      format.json do
        salary_tax_break_up = SalaryTaxBreakup.new(@employee_master, session[:financial_year_from], session[:financial_year_to])
        render :json => salary_tax_break_up.payslip_components_monthly_report(params[:component])
      end
    end
  end
  
  private
  
  def load_employee_master
    @employee_master = EmployeeMaster.find(params[:employee_master_id])
  end


end
