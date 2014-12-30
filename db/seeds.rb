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
    Role.create(:role => "commercial_manager", :code => "manager", :description => "Commercial Manager")
  end

  unless @director.present?
    Role.create(:role => "director", :code => "director", :description => "Director")
  end
  
  unless @accountant.present?
    Role.create(:role => "senior_accountant", :code => "accountant", :description => "Senior Accountant")
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
    User.create(:email => "manager@gmail.com" , :password => "hellohello" , :user_id => "Manager" , :role_id => manager_role.id)
  end

  unless @user_director.present?
    User.create(:email => "director@gmail.com" , :password => "hellohello" , :user_id => "Director" , :role_id => director_role.id)
  end

  unless @user_accountant.present?
    User.create(:email => "accountant@gmail.com", :password => "hellohello", :user_id => "Accountant", :role_id => accountant_role.id)
  end

end

def seed_salary_break_ups
  SalaryBreakUpCreator::BREAK_UPS.each do |break_up|
    SalaryBreakUp.where(:component_code => break_up).first_or_create(:component_code => break_up, :component => break_up.titleize, :criteria => 0, :break_up_type => "salary")
  end
  SalaryBreakUp.where(:component_code => "employee_labour_welfare_fund").first_or_create(:component_code => "employee_labour_welfare_fund", :component => "employee_labour_welfare_fund".titleize, :criteria => 7, :break_up_type => "salary")
  SalaryBreakUp.where(:component_code => "employer_labour_welfare_fund").first_or_create(:component_code => "employer_labour_welfare_fund", :component => "employer_labour_welfare_fund".titleize, :criteria => 14, :break_up_type => "salary")
  SalaryBreakUp.where(:component_code => "loyalty_allowance").first_or_create(:component_code => "loyalty_allowance", :component => "loyalty_allowance".titleize, :criteria => 0, :break_up_type => "salary")
  SalaryBreakUp.where(:component_code => "epf_ee_share").first_or_create(:component_code => "epf_ee_share", :component => "epf_ee_share".titleize, :criteria => 12, :break_up_type => "pf")
  SalaryBreakUp.where(:component_code => "eps_upper_limit").first_or_create(:component_code => "eps_upper_limit", :component => "eps_upper_limit".titleize, :criteria => 15000, :break_up_type => "pf")
  SalaryBreakUp.where(:component_code => "eps_share").first_or_create(:component_code => "eps_share", :component => "eps_share".titleize, :criteria => 8.33, :break_up_type => "pf")
  
end

def seed_remainders
  Reminder.create(:description => "Employee Leaves" , :created_date => "2014-02-12" , :occurrence => "monthly")
end

def seed_day_end
  DayEnd.first_or_create(:transaction_date => Date.today, :scrolled_by => User.first)
end

def seed_all
  seed_roles
  seed_user  
  seed_salary_break_ups
  seed_remainders
  seed_day_end
end

seed_all
