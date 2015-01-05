class Form24Controller < ApplicationController
  
  def get_tds
    forms = Form24.get_tds_pm(current_user, session[:transaction_date].beginning_of_quarter-1)
    respond_to do |format|
      format.json do
        render :json => forms
      end
    end
  end
  
  def index
    @forms = Form24.select('DISTINCT financial_year,quarter')
  end
  
  def save_form
    respond_to do |format|
      format.json do
        x = params[:form_details]
        x.each do |i|
          @temp = Form24.new
          @temp.deposited_date = i['deposited_date']
          @temp.challan_serial_no = i['challan_serial_no']
          @temp.payment_type = i['payment_type']
          @temp.emp_status = i['status']
          @temp.month = i['month']
          @temp.year= i['year']
          @temp.bsr_code = i['bsr_code']
          @temp.edu_cess = i['edu_cess']
          @temp.tds = i['tds']
          @temp.total_tax_deposited = i['total_tax_deposited']
          @temp.cheque_no = i['cheque_no']
         
          if @temp.month > 3 
            @temp.financial_year = @temp.year
          else
            @temp.financial_year = @temp.year - 1
          end
          p "sfdhgrdthyfjugh"
          p @temp.month
          if @temp.month =  4 or 5 or 6
            @temp.quarter = 1
          elsif @temp.month =   7 or 8 or 9
            @temp.quarter = 2
          elsif @temp.month = 10 or 11 or 12
            @temp.quarter = 3
          elsif @temp.month = 1 or 2  or 3
            @temp.quarter = 4
          end
          p "222222222222223333333"
          p @temp.quarter
          @temp.save
        end
        redirect_to form24_index_path
      end
    end
  end
  
  def get_annexure_report
    respond_to do |format|
      if params[:year].present?
        year_from = params[:year].split('-')[0].to_i
        year_to = params[:year].split('-')[1].to_i
        from_date = Date.new(year_from , 04, 1)
        to_date = Date.new(year_to , 03, 31)
        @forms = SalaryTax.manageable_by_current_user(current_user).in_the_financial_year(from_date , to_date).all
      else
        @forms = SalaryTax.manageable_by_current_user(current_user).all
      end
      format.pdf do
        render :json => @forms
      end
      format.pdf do
        render :pdf => "Annexure",
        :formats => [:pdf, :haml],
        :page_size => 'A4',
        :margin => {:top => '8mm',
          :bottom => '8mm',
          :left => '10mm',
          :right => '10mm'}
      end
    end 
  end
  def annexure
    if params[:year].present?
      year_from = params[:year].split('-')[0].to_i
      year_to = params[:year].split('-')[1].to_i
      from_date = Date.new(year_from , 04, 1)
      to_date = Date.new(year_to , 03, 31)
      @forms = SalaryTax.manageable_by_current_user(current_user).in_the_financial_year(from_date , to_date).all
    else
      @forms = SalaryTax.manageable_by_current_user(current_user).all
    end
    respond_to do |format|
      format.html{}
      format.pdf do
        render :pdf => "Annexure",
        :formats => [:pdf],
        :page_size => 'A4',
        :orientation => 'Landscape',
        :margin => {:top => '8mm',
          :bottom => '8mm',
          :left => '10mm',
          :right => '10mm'}
      end
    end
  end
 
  
  def show
    @forms = Payslip.where(:generated_date => params[:generated_date])
  end
  
  def payslips
    @form24 = Form24.find(params[:id])
    @forms = Payslip.manageable_by_user(current_user).in_the_year(params[:year]).in_the_mon(params[:month]).having_status(params[:status]).all
  end
  
  def quarter_details
    @forms = Form24.in_the_quarter(params[:quarter]).in_the_financial_year(params[:financial_year])
  end
  
   
  def edit
  end
  
  def create
  end
  
  def new
    last_quarter_date = session[:transaction_date].beginning_of_quarter-1
    current_quarter = FinancialYearCalculator.new(last_quarter_date).current_quarter_num
    if Form24.in_the_quarter(current_quarter).in_the_financial_year(last_quarter_date.year).count >  0
      flash[:alert] = "Form24 has already been generated for the quarter"
      redirect_to form24_index_path
    end
  end
  
end
