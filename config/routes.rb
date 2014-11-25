PayrollManagement::Application.routes.draw do

  resources :designation_masters do
    collection do
      get "map"
      get "ind"
      
      post 'save_designation'
    end
  end
  # get "/designation_masters/map"
  # get "/designation_masters/index"
  # post "/designation_masters/save_designation"
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
  
  get "/payslips/new_payslips"
  get "/payslips" => "payslips#index"
  post "/payslips/create_payslips"
  post "/payslips/approve_payslips"
  post "/payslips/email_payslips"
  
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
    end
  end
  devise_for :users
  root to: "home#index"
end
