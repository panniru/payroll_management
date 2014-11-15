require 'rails_helper'

RSpec.describe "employee_masters/new", :type => :view do
  before(:each) do
    assign(:employee_master, EmployeeMaster.new(
      :code => "MyString",
      :name => "MyString",
      :designation_id => 1,
      :department_id => 1,
      :gender => "MyString",
      :initials => "MyString",
      :qualification => "MyString",
      :p_f_no => "MyString",
      :bank_name => "MyString",
      :account_number => "MyString",
      :pan => "MyString"
    ))
  end

  it "renders new employee_master form" do
    render

    assert_select "form[action=?][method=?]", employee_masters_path, "post" do

      assert_select "input#employee_master_code[name=?]", "employee_master[code]"

      assert_select "input#employee_master_name[name=?]", "employee_master[name]"

      assert_select "input#employee_master_designation_id[name=?]", "employee_master[designation_id]"

      assert_select "input#employee_master_department_id[name=?]", "employee_master[department_id]"

      assert_select "input#employee_master_gender[name=?]", "employee_master[gender]"

      assert_select "input#employee_master_initials[name=?]", "employee_master[initials]"

      assert_select "input#employee_master_qualification[name=?]", "employee_master[qualification]"

      assert_select "input#employee_master_p_f_no[name=?]", "employee_master[p_f_no]"

      assert_select "input#employee_master_bank_name[name=?]", "employee_master[bank_name]"

      assert_select "input#employee_master_account_number[name=?]", "employee_master[account_number]"

      assert_select "input#employee_master_pan[name=?]", "employee_master[pan]"
    end
  end
end
