class RenameProffesionalTaxToProfessionalTaxInDefaultAllowanceDeductions < ActiveRecord::Migration
  def change
    rename_column :default_allowance_deductions, :proffesional_tax, :professional_tax
  end
end
