require 'rails_helper'

RSpec.describe "employee_masters/index", :type => :view do
  before(:each) do
    assign(:employee_masters, [
      EmployeeMaster.create!(
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
      ),
      EmployeeMaster.create!(
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
      )
    ])
  end

  it "renders a list of employee_masters" do
    render
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Gender".to_s, :count => 2
    assert_select "tr>td", :text => "Initials".to_s, :count => 2
    assert_select "tr>td", :text => "Qualification".to_s, :count => 2
    assert_select "tr>td", :text => "P F No".to_s, :count => 2
    assert_select "tr>td", :text => "Bank Name".to_s, :count => 2
    assert_select "tr>td", :text => "Account Number".to_s, :count => 2
    assert_select "tr>td", :text => "Pan".to_s, :count => 2
  end
end
