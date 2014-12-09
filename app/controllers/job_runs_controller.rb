class JobRunsController < ApplicationController
  load_resource :only => [:show]
  authorize_resource
  def index
    page = params[:page].present? ? params[:page] : 1
    @job_runs = JobRun.matching_code(JobRun::PAYSLIP_MAILING).paginate(:page => page)
  end

  def show

  end


end
