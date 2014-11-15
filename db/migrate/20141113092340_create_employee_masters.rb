class CreateEmployeeMasters < ActiveRecord::Migration
  def change
    create_table :employee_masters do |t|
      t.string :code, unique: true
      t.string :name
      t.integer :designation_master_id
      t.integer :department_master_id
      t.string :gender
      t.string :initials
      t.string :qualification
      t.date :date_of_joining
      t.date :probation_date
      t.date :confirmation_date
      t.string :p_f_no
      t.string :bank_name
      t.string :account_number
      t.string :pan

      t.timestamps
    end
  end
end
