class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :description
      t.date :created_date
      t.string :occurrence
    end
  end
end
