class PreviousResolutionDateToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :previous_resolution_date, :date
  end
end
