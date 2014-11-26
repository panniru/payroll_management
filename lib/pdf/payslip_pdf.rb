class PayslipPdf  #< Prawn::Document
  include Prawn::View
  
  def initialize(payslip)
    super()
    @payslip = payslip
    @date = payslip.generated_date
  end

  def payslip
    heading = "<font size = '15'> <b>PAYSLIP FOR THE MONTH OF #{Date.today.strftime('%b').upcase} #{Date.today.strftime('%Y')}</b></font>"
    body_rows = [[logo],[payslip_header], [part_1], [{:content => heading, :padding_left => 130}], [part_2], [part_2_totals], [part_3]] #
    table(body_rows, :cell_style => { :inline_format => true })
    #encrypt_document(:user_password => 'welcome', :owner_password => 'welcome')
  end
  
  private

  def logo
    logo = "#{Rails.root}/app/assets/images/logo.jpg"
    make_table([[{:image => logo, :image_height => 20,:image_width => 100, :position => :right}]], :cell_style =>{:border_width => 0}, :position => :right)
  end

  def payslip_header
    org_details = "<font size= '10'> <b>#{I18n.t(:name, :scope => :organization)}</b></font>\n"+
      "<font>#{I18n.t(:address_line2, :scope => :organization)} #{I18n.t(:city, :scope => :organization)}<font>\n"+
      "<font>#{I18n.t(:state, :scope => :organization)} - #{I18n.t(:pin, :scope => :organization)}</font>"
    row_data = [
                [{:content => org_details, :rowspan => 2, :width => 200}, "Name", {:content => "<b>#{@payslip.employee_master.name}</b>"}, {:content => "FORM - T - WAGE SLIP", :rowspan => 2, :min_font_size => 16, :width => 200}],
                ["Designation", {:content => "<b>#{@payslip.employee_master.designation_master.name}</b>"}]
               ]
    make_table(row_data, :cell_style => { :inline_format => true })
  end

  def part_1
    employee_leave_obj = @payslip.employee_master.employee_leaves.in_th_month_year(@date).first
    header_data = [
                   [{:content => "PF Details", :colspan => 2}, {:content => "Bank Details", :colspan => 2}, {:content => "Leave Balance details (days)", :colspan => 2}],

                   ["Date Of Joining", @payslip.employee_master.date_of_joining, "Pay Mode", "Transfer to Bank", "Sick Leave", employee_leave_obj.try(:sl).to_i],
                   ["PF Number", @payslip.employee_master.p_f_no, "Bank Name", @payslip.employee_master.bank_name, "Casual Leave", employee_leave_obj.try(:cl).to_i],
                   ["Employee code no.", @payslip.employee_master.code, "SB A/c. No", @payslip.employee_master.account_number.to_s, "Total Leave", (employee_leave_obj.try(:sl).to_i + employee_leave_obj.try(:cl).to_i)],
                   ["PAN", @payslip.employee_master.pan, "Days Worked", employee_leave_obj.try(:days_worked).to_i, "LOP", employee_leave_obj.try(:lop).to_i]
                  ]
    make_table(header_data, :cell_style => {:height => 25})
  end

  def part_2
    earnings_table_data = []
    Payslip::EARNINGS.map do |component|
      if @payslip.send(component).present?
        key = component.to_s.titleize
        if key == "Hra"
          key = "HRA"
        end
        earnings_table_data << [key, @payslip.send(component)]
      end
    end
    #earnings_table_data << ["TOTAL", @payslip.total_earnings]
    
    deductions_table_data = []
    Payslip::DEDUCTIONS.map do |component|
      key = component.to_s.titleize
      if key == "Pf" or key == "Tds Pm"
        key = key.upcase.gsub("PM", "")
      end

      if @payslip.send(component).present?
        deductions_table_data << [key, @payslip.send(component)]
      end
    end
    #deductions_table_data << ["TOTAL", @payslip.total_deductions]
    outer_table_data = [[{:content  => "EARNINGS (in Rupees)", :width => 270}, {:content => "DEDUCTIONS (in Rupees)", :width => 270}], [{:content => make_table(earnings_table_data, :column_widths => [135, 135]), :width => 270}, {:content => make_table(deductions_table_data, :column_widths => [135, 135]), :width => 270}]]

    make_cell(:content => make_table(outer_table_data))
  end

  def part_2_totals
    data = [["TOTAL", @payslip.total_earnings, "TOTAL", @payslip.total_deductions]]
    make_table(data, :column_widths => [135, 135, 135, 135])
  end

  def part_3
    footer_rows = [
                   ["EMPLOYEE SIGNATURE", "AUTHORISED SIGNATORY", "NET PAY Rs."],
                   ["", "", @payslip.net_total]
                  ]
    make_table(footer_rows, :column_widths => [180, 180, 180]) do |t|
      t.row(1).height = 60
    end
  end
  
  
end
