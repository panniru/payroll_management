class HomeController < ApplicationController
  def index
    @reminders = Reminder.all.select{|rm| rm.active?(session[:transaction_date])}
  end
end
