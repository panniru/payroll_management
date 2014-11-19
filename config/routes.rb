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
  end
  
  
  resources :employee_leaves do
    collection do
      post "upload"
      get "new_upload"
      get "mapping"
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
