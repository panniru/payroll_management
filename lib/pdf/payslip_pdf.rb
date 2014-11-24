class PayslipPdf
  include Prawn::View
  
  def initialize(payslip, date)
    super()
    @payslip = payslip
    @date = date
    payslip
  end

  def payslip
    body_rows = [[logo], [header], [part_1], [part_2], [part_3]]
    p body_rows
    table(body_rows)
  end
  
  private

  def logo
    image_path = "#{Prawn::DATADIR}/images/logo.jpg"
    table([[{:image => image_path}, "", my_table, ""]])
  end

  def org_details
    font_size 16
    text I18n.t(:name, :scope => :organization)
    move_down 5
    text I18n.t(:address_line1, :scope => :organization)
    move_down 5
    text "#{I18n.t(:address_line2, :scope => :organization)} #{I18n.t(:city, :scope => :organization)}"
    move_down 5
    text "#{I18n.t(:state, :scope => :organization)} - #{I18n.t(:pin, :scope => :organization)}"
  end
  
  def header
    row_data = [
                [{:content => org_details, :rowspan => 2}, ["Name", @payslip.employee_master.name], {:content => "FORM - T - WAGE SLIP", :colspan => 2, :font_size => 16, :font_weight => "bold"}],
                ["Designation", @payslip.employee_master.designation_master.name]
               ]
    table(row_data)
  end

  def part_1
    employee_leave_obj = @payslip.employee_master.employee_leaves.in_th_month_year(@date).first
    header_data = [
                   [{:content => "PF Details", :colspan => 2}, {:content => "Bank Details", :colspan => 2}, {:content => "Leave Balance details (days)", :colspan => 2}],
                   ["Date Of Joining", @payslip.employee_master.date_of_joining, "Pay Mode", "Transfer to Bank", "Sick Leave", employee_leave_obj.sl],
                   ["PF Number", @payslip.employee_master.pf_no, "Bank Name", @payslip.employee_master.bank_name, "Casual Leave", employee_leave_obj.cl],
                   ["Employee code no.", @payslip.employee_master.code, "SB A/c. No", @payslip.employee_master.account_number, "Total Leave", (employee_leave_obj.sl + employee_leave_obj.cl)]
                   
                  ]
    table(header_data)
  end

  def part_2
    earnings_table_data = @payslip.EARNINGS.map do |component|
      if @payslip.send(component).present?
        [componet.to_s, @payslip.send(component)]
      end
    end
    earnings_table_data << ["TOTAL", @payslip.total_earnings]
    
    deductions_table_data = @payslip.DEDUCTIONS.map do |component|
      if @payslip.send(component).present?
        [componet.to_s, @payslip.send(component)]
      end
    end
    deductions_table_data << ["TOTAL", @payslip.total_deductions]
    
    outer_table_data = [["EARNINGS (in Rupees)" , "DEDUCTION (in Rupees)"], [table(earnings_table_data), table(deductions_table_data)]]
    table(outer_table_data)
  end


  def part_3
    footer_rows = [
                   ["EMPLOYEE SIGNATURE", "AUTHORISED SIGNATORY", "NET PAY Rs."],
                   ["", "", @payslip.net_total]
                  ]
    table(footer_rows)
  end
  
  
end
