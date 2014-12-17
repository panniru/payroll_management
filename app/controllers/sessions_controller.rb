class SessionsController  < Devise::SessionsController

  def create
    super
    session[:transaction_date] = Date.today
    session[:financial_year_from] = Date.new(2014, 04, 01)
    session[:financial_year_to] = Date.new(2015, 04, 01)
  end

end
