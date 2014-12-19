class SessionsController  < Devise::SessionsController

  def create
    super
    session[:transaction_date] = Date.today
    if session[:transaction_date].month > 3
      session[:financial_year_from] = Date.new(session[:transaction_date].year, 04, 01)
    else
      session[:financial_year_from] = Date.new(session[:transaction_date].year -1, 04, 01)
    end
    session[:financial_year_to] = Date.new(session[:financial_year_from].year+1, 04, 01)    
    session[:financial_year] = "#{session[:financial_year_from].year} #{session[:financial_year_to].year.to_s[2..3]}"
  end

end
