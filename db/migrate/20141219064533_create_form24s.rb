class CreateForm24s < ActiveRecord::Migration
  def change
    create_table :form24s do |t|
      t.integer :quarter
      t.integer :financial_year
      t.string :cheque_no
      t.string :edu_cess
      t.string :tds
      t.date :created_date
      t.string :emp_status
      t.integer :month
      t.integer :year
      t.date :deposited_date
      t.float :total_tax_deposited
      t.string :challan_serial_no
      t.string :bsr_code
      t.string :payment_type
      t.integer :surcharge

      t.timestamps
    end
  end
end
