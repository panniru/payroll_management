PayrollManagement::Application.routes.draw do

  resources :reminders

  resources :designation_masters do
    collection do
      get "map"
      get "ind"
      post 'save_designation'
    end
  end
 
  resources :salary_break_ups do
    collection do
      put :update_all
      get :break_up_report
    end
  end
  
  resources :employee_masters do
    collection do
      get :autocomplete_department_master_name
      get :autocomplete_designation_master_name
      get :autocomplete_employee
      get :new_upload
      post :upload
      get :search
    end
    resources :employee_advance_payments do
      collection do
        get :search_by_month
      end
    end
    resources :payslips do
      member do
        get "mail"
      end
    end
  end
  
  get "default_allowance_deductions" => "default_allowance_deductions#index"
  get "default_allowance_deductions/new_upload"
  post "default_allowance_deductions/upload"
  delete "default_allowance_deductions/delete_all"

  get "/payslips/new_payslips"
  get "/payslips" => "payslips#index"
  post "/payslips/create_payslips"
  post "/payslips/approve_payslips"
  get "/payslips/new_email_payslips"
  get "/payslips/email_payslips"
  get "/payslips/bank_advice"

  resources :employee_leaves do
    collection do
      post "upload"
      get "new_upload"
      get "mapping"
      get "get_leaves"
      get "export"
    end
  end


  resources :home do
    collection do
      get "edit_user"
      put "edit_user_index"
    end
  end

  resources :job_runs

  get "/job_runs/:job_run_id/pf_statements" => "pf_statements#index"
  get "/pf_statements/schedule"
  get "/pf_statements/list_jobs"
  

  devise_for :users, :controllers => {:registrations => 'registrations' , :sessions => 'sessions'}
  root to: "home#index"
end
