# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


def seed_roles

  @manager = Role.find_by_code("manager")
  @director = Role.find_by_code("director")
  @accountant = Role.find_by_code("accountant")


  unless @manager.present?
    Role.create(:role => "manager", :code => "manager", :description => "manager")
  end

  unless @director.present?
    Role.create(:role => "director", :code => "director", :description => "director")
  end
  
  unless @accountant.present?
    Role.create(:role => "accountant", :code => "accountant", :description => "accountant")
  end
  
  
end

def seed_user
  manager_role = Role.find_by_code("manager")
  director_role = Role.find_by_code("director")
  accountant_role = Role.find_by_code("accountant")
  
  @user_manager = User.find_by_role_id(manager_role)
  @user_director = User.find_by_role_id(director_role)
  @user_accountant = User.find_by_role_id(accountant_role)
  

  unless @user_manager.present?
    User.create(:email => "manager@gmail.com" , :password => "welcome" , :user_id => "manager" , :role_id => manager_role.id)
  end

  unless @user_director.present?
    User.create(:email => "director@gmail.com" , :password => "welcome" , :user_id => "director" , :role_id => director_role.id)
  end

  unless @user_accountant.present?
    User.create(:email => "accountant@gmail.com", :password => "welcome", :user_id => "accountant", :role_id => accountant_role.id)
  end

end

def seed_salary_break_ups
  # SalaryBreakUpCreator::BREAK_UPS.each do |break_up|
  #   SalaryBreakUp.find_or_create_by(:component_code => break_up, :component => break_up.titleize, :criteria => 0)
  # end
  SalaryBreakUp.first_or_create(:component => 'Basic',:component_code => 'Basic', :criteria => '50')
  SalaryBreakUp.create(:component => 'Hra' ,:component_code => 'Hra' ,:criteria => '12')
  SalaryBreakUp.create(:component => ' Medical Allowance',:component_code => ' Medical Allowance', :criteria => '500')
  SalaryBreakUp.create(:component => ' Conveyance Allowance',:component_code => ' Conveyance Allowance', :criteria => '200')
  SalaryBreakUp.create(:component => '  City Compensatory Allowance',:component_code => '  City Compensatory Allowance', :criteria => '10')
  SalaryBreakUp.create(:component => ' Special Allowance',:component_code => ' Special Allowance', :criteria => '40')
  SalaryBreakUp.create(:component => ' Employer Pf Contribution',:component_code => ' Employer Pf Contribution', :criteria => '10')
  SalaryBreakUp.create(:component => ' Bonus Payment',:component_code => ' Bonus Payment', :criteria => '10')
  SalaryBreakUp.create(:component => ' Grade Allowance',:component_code => ' Grade Allowance', :criteria => '900')
  SalaryBreakUp.create(:component => ' Incentive Payment',:component_code => ' Incentive Payment', :criteria => '100')
end

def seed_all
  seed_roles
  seed_user  
  seed_salary_break_ups
end

seed_all
