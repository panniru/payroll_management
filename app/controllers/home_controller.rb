class HomeController < ApplicationController
  def index
    @reminders = Reminder.all.select{|rm| rm.active?(session[:transaction_date])}
  end
  def edit_user
    @users = User.all
  end
end
