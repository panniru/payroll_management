class CreateSalaryTaxes < ActiveRecord::Migration
  def change
    create_table :salary_taxes do |t|
      t.integer :employee_master_id
      t.string :financial_year
      t.integer :rent_paid
      t.integer :rent_per_month
      t.string :rent_receipt
      t.integer :standard_deduction
      t.integer :home_loan_amount
      t.string :home_loan_document
      t.integer :rent_received
      t.integer :other_tax
      t.integer :total_tax_projection
      t.integer :tax_paid
      t.integer :educational_cess
      t.integer :surcharge

      t.integer :atg

      t.timestamps
    end
  end
end
