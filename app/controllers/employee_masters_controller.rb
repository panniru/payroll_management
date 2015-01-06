class EmployeeMastersController < ApplicationController
  before_action :set_employee_master, only: [:show, :edit, :update, :destroy]
  autocomplete :department_master, :name
  autocomplete :designation_master, :name
  
  def autocomplete_employee
    term = params[:term]
    employees = EmployeeMaster.managed_by(current_user).where('lower(code) ILIKE ? OR lower(name) LIKE ?', "%#{term.downcase}%", "%#{term.downcase}%").order(:name).all
    render :json => employees.map { |employee| {:id => employee.id, :label => "#{employee.code} #{employee.name}", :value => employee.name} }
  end

  # GET /employee_masters
  # GET /employee_masters.json
  def index
    page = params[:page].present? ? params[:page] : 1
    @employee_masters = EmployeeMaster.managed_by(current_user).order("code").paginate(:page => page)
  end

  def search
    @employee = EmployeeMaster.all
    @employee_master = EmployeeMaster.where(:id => params[:search]).first
    if @employee_master.present?
      render "show"
    else
      flash[:error] = "No Employee Found"
      redirect_to employee_masters_path
    end
  end
  
  def reports
    if  params[:status] == "Attrition"
      @employee_masters = EmployeeMaster.resignation_between( params[:from_date] , params[:to_date])
    else
      @employee_masters = EmployeeMaster.joined_between( params[:from_date] , params[:to_date])
    end
  end

 
  def get_reports
    respond_to do |format|
      if  params[:status] == "Attrition"
        @employee_masters = EmployeeMaster.resignation_between( params[:from_date] , params[:to_date])
      else
        @employee_masters = EmployeeMaster.joined_between( params[:from_date] , params[:to_date])
      end
      format.json do
        leaves= @employee_masters.map do |field|
          {id: id, code: field.code, name: field.name, designation_master_id: field.designation_master_id, department_master_id: field.department_master_id}
        end
        render :json => leaves
      end
      format.pdf do
        render :pdf => "Employee Details",
        :formats => [:pdf, :haml],
        :page_size => 'A4',
        :margin => {:top => '8mm',
          :bottom => '8mm',
          :left => '10mm',
          :right => '10mm'}
      end
    end
  end

  # GET /employee_masters/1
  # GET /employee_masters/1.json
  def show
  end

  # GET /employee_masters/new
  def new
    @employee_master = EmployeeMaster.new
  end

  # GET /employee_masters/1/edit
  def edit
    
    @employee_master.designation_name = @employee_master.designation_master.name
    @employee_master.department_name = @employee_master.department_master.name
  end

  # POST /employee_masters
  # POST /employee_masters.json
  def create
    @employee_master = EmployeeMaster.new(employee_master_params)
    respond_to do |format|
      if @employee_master.save_employee
        format.html { redirect_to @employee_master, notice: 'Employee master was successfully created.' }
        format.json { render action: 'show', status: :created, location: @employee_master }
      else
        format.html { render action: 'new' }
        format.json { render json: @employee_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_masters/1
  # PATCH/PUT /employee_masters/1.json
  def update
    respond_to do |format|
      if @employee_master.update(employee_master_params)
        format.html { redirect_to @employee_master, notice: 'Employee master was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @employee_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_masters/1
  # DELETE /employee_masters/1.json
  def destroy
    @employee_master.destroy
    respond_to do |format|
      format.html { redirect_to employee_masters_url }
      format.json { head :no_content }
    end
  end

  def new_upload
    @employee_master_uploader = EmployeeMasterUploader.new
    respond_to do |format|
      format.html { render "new_upload"}
      format.xlsx { send_data @employee_master_uploader.xls_template, :filename=>"payroll_employee_sample.xlsx"}
    end
  end
  
  def upload
    @employee_master_uploader = EmployeeMasterUploader.new(params[:employee_master_uploader])
    if @employee_master_uploader.save
      flash[:success] = "Employees Successfully uploaded"
      redirect_to employee_masters_path
    else
      flash[:error] = "Some problem occured while uploading.."
      render "new_upload"
    end
  end
  
  def form16
    @salary_tax = @employee_master.salary_taxes.in_the_financial_year(session[:financial_year_from], session[:financial_year_to]).first
    @form16 = Form16.new(@employee_master, @salary_tax)
    respond_to do |format|
      format.html{}
      format.pdf do
        render :pdf => "#{@employee_master.name}_form_16.pdf",
        :formats => [:pdf],
        :page_size => 'A4'
      end
    end
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_employee_master
    @employee_master = EmployeeMaster.find(params[:id])
    unless @employee_master.readable_by_user? current_user
      raise CanCan::AccessDenied
    end
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def employee_master_params
    params.require(:employee_master).permit(:code, :name, :designation_master_id, :department_master_id, :gender, :initials, :qualification, :date_of_joining, :probation_date, :confirmation_date, :p_f_no, :bank_name, :account_number, :pan, :designation_name, :department_name, :ctc, :basic, :father_or_husband_name, :relation, :resignation_date, :reason_for_resignation, :status, :date_of_birth)
  end
end
  
