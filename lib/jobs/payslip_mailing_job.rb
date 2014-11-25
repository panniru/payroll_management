class PayslipMailingJob

  def initialize(scrolled_by, date)
    @scrolled_by = scrolled_by
    @date = date
    @job_run_id = JobRun.schedule(JobRun::PAYSLIP_MAILING, scrolled_by, date).id
  end

  def perform
    Payslip.in_the_current_month(@date).each do |payslip|
      PayslipMailer.payslip(payslip).deliver if payslip.employee_master.email.present?
    end
  end
  
  def success(job)
    JobRun.finish_as_success(@job_run_id)
  end

  def error(job, error)
    JobRun.finish_as_error(@job_run_id)
  end

  def failure(job)
    JobRun.finish_as_failed(@job_run_id)
  end
  
end
