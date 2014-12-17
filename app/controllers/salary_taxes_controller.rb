class SalaryTaxesController < ApplicationController
  before_action :load_employee_master, :except => [:tax_limits]
  load_resource :only => [:show, :update, :edit]
  authorize_resource

  def new
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
        status = SalaryTaxCreationService.new(@employee_master, params[:salary_tax]).save
      }
      format.json do
        render :json => status
      end
    end
  end

  def edit
    respond_to do |format|
      format.html {}
      format.json do
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
  
  private
  
  def load_employee_master
    @employee_master = EmployeeMaster.find(params[:employee_master_id])
  end


end
