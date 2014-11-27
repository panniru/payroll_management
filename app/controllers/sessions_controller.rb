class SessionsController  < Devise::SessionsController
  def create
    super
    session[:transaction_date] = Date.today
  end
end
