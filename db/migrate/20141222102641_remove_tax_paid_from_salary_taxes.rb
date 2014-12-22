class RemoveTaxPaidFromSalaryTaxes < ActiveRecord::Migration
  def change
    remove_column :salary_taxes, :tax_paid, :integer
  end
end
