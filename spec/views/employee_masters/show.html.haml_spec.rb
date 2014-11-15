require 'rails_helper'

RSpec.describe "employee_masters/show", :type => :view do
  before(:each) do
    @employee_master = assign(:employee_master, EmployeeMaster.create!(
      :code => "Code",
      :name => "Name",
      :designation_id => 1,
      :department_id => 2,
      :gender => "Gender",
      :initials => "Initials",
      :qualification => "Qualification",
      :p_f_no => "P F No",
      :bank_name => "Bank Name",
      :account_number => "Account Number",
      :pan => "Pan"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Code/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Gender/)
    expect(rendered).to match(/Initials/)
    expect(rendered).to match(/Qualification/)
    expect(rendered).to match(/P F No/)
    expect(rendered).to match(/Bank Name/)
    expect(rendered).to match(/Account Number/)
    expect(rendered).to match(/Pan/)
  end
end
