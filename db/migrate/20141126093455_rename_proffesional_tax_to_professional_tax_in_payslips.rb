class RenameProffesionalTaxToProfessionalTaxInPayslips < ActiveRecord::Migration
  def change
    rename_column :payslips, :proffesional_tax, :professional_tax
  end
end
