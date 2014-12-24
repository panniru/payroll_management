class Form24Controller < ApplicationController
  
  def get_tds
    forms = Form24.get_tds_pm(current_user, Date.today.beginning_of_quarter)
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
          if @temp.month = [4, 5,6]
            @temp.quarter = 1
          elsif @temp.month = [7,8,9]
            @temp.quarter = 2
          elsif @temp.month = [10,11,12]
            @temp.quarter = 3
          elsif @temp.month = [1,2,3]
            @temp.quarter = 4
          end
          @temp.save
        end
        redirect_to form24_index_path
      end
    end
  end
  
  def annexure
    @forms = SalaryTax.manageable_by_current_user(current_user).in_the_financial_year(session[:financial_year_from], session[:financial_year_to]).all
  end
  
  def show
    @forms = Payslip.where(:generated_date => params[:generated_date])
  end
  
  def payslips
    @form24 = Form24.find(params[:id])
    @forms = Payslip.manageable_by_user(current_user).in_the_year(params[:year]).in_the_mon(params[:month]).having_status(params[:status]).all
  end
  
  def quarter_details
    # @months = ('2014/12/12'..'2014/01/01').map{|m| m.beginning_of_month}.uniq.map{|m| Date::ABBR_MONTHNAMES[m.month]}
    # p @months
    @forms = Form24.in_the_quarter(params[:quarter]).in_the_financial_year(params[:financial_year])
  end
  
  def quarter_dates(x)
    date = Date.today << (x * 3)
    [date.beginning_of_quarter, date.end_of_quarter]
  end
  
  
  
  def edit
  end
  
  def create
  end
  
  def new
  end
  
end
