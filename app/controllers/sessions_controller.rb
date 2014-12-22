class SessionsController  < Devise::SessionsController

  def create
    super
    session[:transaction_date] = Date.today
    finanancial_year_from = FinancialYearCalculator.new(session[:transaction_date])
    session[:financial_year_from] = finanancial_year_from.financial_year_from
    session[:financial_year_to] = finanancial_year_from.financial_year_to
    session[:financial_year] = "#{session[:financial_year_from].year} #{session[:financial_year_to].year.to_s[2..3]}"
  end

end
