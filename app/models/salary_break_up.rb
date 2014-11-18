class SalaryBreakUp < ActiveRecord::Base
  validates :component, :presence => true
  validates :component_code, :presence => true
  validates :criteria, :presence => true, numericality: true
  
  def component_description
    "#{SalaryBreakUpInitializer::BREAK_UP_FORUMULA_DESC[component_code.to_sym]}"
  end
end
