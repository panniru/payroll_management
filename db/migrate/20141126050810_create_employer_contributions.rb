class CreateEmployerContributions < ActiveRecord::Migration
  def change
    create_table :employer_contributions do |t|
      t.integer :payslip_id
      t.integer :employee_master_id
      t.integer :pf
      t.integer :bonus_payment
      t.date :generated_date
    end
  end
end
