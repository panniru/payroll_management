class PayslipMailer < ActionMailer::Base
  default from: "from@example.com"
  

  def payslip(payslip)
    @employee_master = payslip.employee_master
    date = payslip.generated_date
    attachments["Payslip_#{date.strftime('%b')}_#{date.strftime('%Y')}.pdf"] =  {
      mime_type: 'application/pdf',
      content: payslip.pdf.render
    }
    mail(to: @employee_master.email, subject: "payslip #{date.strftime('%b')} #{date.strftime('%Y')}.pdf")
  end
  
end
