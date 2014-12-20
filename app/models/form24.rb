class Form24 < ActiveRecord::Base
  scope :in_the_quarter, lambda{|quarter| where(:quarter => quarter)}
  scope :in_the_financial_year, lambda{|year| where(:financial_year => year)}
  def tds_paid(x)
    a = x.tds << x.edu_cess
    p "111111111"
    p a
  end

end
