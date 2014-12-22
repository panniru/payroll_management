module DesignationMastersHelper

  def accountant_role
    @accountant ||= Role.find_by_code("accountant")
  end

  def manager_role
    @manager ||= Role.find_by_code("manager")
  end
end
