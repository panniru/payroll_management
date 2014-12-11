class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_current_user
  rescue_from Grant::Error, with: :deny_access 
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:user_id, :email) }
    devise_parameter_sanitizer.for(:account_update) { |u| 
      u.permit(:id , :email ,:password, :password_confirmation, :current_password ) 
    }
  end
  after_filter :set_csrf_cookie_for_ng
  
  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end
  
  protected
  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  def deny_access
    flash[:alert] = "You are not authorized to access"
    redirect_to root_path
  end

  private
  def set_current_user
    Grant::User.current_user = current_user
  end
end
