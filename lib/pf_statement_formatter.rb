require 'rubygems'       
require 'spreadsheet'
require 'roo'
class PfStatementFormatter
  HEADERS = [:member_id, :member_name, :epf_wages, :eps_wages, :epf_ee_share, :epf_ee_remitted, :eps_due, :eps_remitted, :diff_epf_and_eps, :diff_remitted, :n, :refund_adv, :arrear_epf, :arrear_epf_ee, :arrear_epf_er, :arrear_eps, :fathers_husbands_name, :relation, :emp_dob, :emp_gender, :doj_epf, :doj_eps, :doe_epf, :doe_eps, :r]

  def initialize(pf_statements)
    @pf_statements = pf_statements
  end

  def xls_template
  end

  def csv(oprions ={})
    CSV.generate(options) do |csv|
      @pf_statements.each do |pf_statement|
        csv << HEADERS.map{|head| pf_statement.send(head)} 
      end 
    end
  end
  
  def pdf
  end
end
