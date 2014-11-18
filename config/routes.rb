PayrollManagement::Application.routes.draw do

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
        get "search_by_month"
      end
    end
  end

  devise_for :users
  root to: "home#index"
end
