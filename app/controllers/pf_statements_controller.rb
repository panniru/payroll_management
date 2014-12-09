class PfStatementsController < ApplicationController
  before_action :load_job_run, :only => [:index]
  authorize_resource
  
  def list_jobs
    page = params[:page].present? ? params[:page] : 1
    @job_runs = JobRun.matching_code(JobRun::PF_STATEMENT).paginate(:page => page)
  end
  
  def index
    respond_to do |format|
      format.html do
        page = params[:page].present? ? params[:page] : 1
        @pf_statements = @job_run.pf_statements.paginate(:page => page)
        @pf_statements = PfStatementDecorator.decorate_collection(@pf_statements)
      end
      format.pdf do
        @pf_statements = @job_run.pf_statements
        @pf_statements = PfStatementDecorator.decorate_collection(@pf_statements)
        render :pdf => "pf_statement_#{@month}_#{@year}",
        :formats => [:pdf],
        :page_size => 'A4',
        :orientation => 'Landscape'
      end
    end
  end
  
  def schedule
    @month = session[:transaction_date].strftime("%b")
    @year = session[:transaction_date].strftime("%Y")
    job_run = JobRun.matching_code(JobRun::PF_STATEMENT).in_the_month(@month).in_the_year(@year).first
    unless job_run.present? and (job_run.scheduled? or job_run.finished?)
      pf_job = PfStatementGenerator.new(current_user, session[:transaction_date])
      Delayed::Job.enqueue pf_job
      result_link = "<a href=\"/job_runs/#{pf_job.job_run_id}/pf_statements\">here</a>"
      flash[:success] = I18n.t :success, :scope => [:job, :schedule], job: JobRun::PF_STATEMENT.titleize, job_link: result_link
    else
      result_link = "<a href=\"/job_runs/#{job_run.id}/pf_statements\">here</a>"
      if job_run.scheduled?
        flash[:alert] = I18n.t :already_scheduled, :scope => [:job, :schedule], job: JobRun::PF_STATEMENT.titleize, job_link: result_link
      elsif job_run.finished?
        flash[:alert] = I18n.t :already_finished, :scope => [:job, :schedule], job: JobRun::PF_STATEMENT.titleize, job_link: result_link
      end
    end
    redirect_to pf_statements_list_jobs_path
  end
  
  private

  def load_job_run
    @job_run = JobRun.find(params[:job_run_id])
  end
end
