require 'rails_helper'

RSpec.describe "salary_break_ups/new", :type => :view do
  before(:each) do
    assign(:salary_break_up, SalaryBreakUp.new(
      :component => "MyString",
      :criteria => 1.5
    ))
  end

  it "renders new salary_break_up form" do
    render

    assert_select "form[action=?][method=?]", salary_break_ups_path, "post" do

      assert_select "input#salary_break_up_component[name=?]", "salary_break_up[component]"

      assert_select "input#salary_break_up_criteria[name=?]", "salary_break_up[criteria]"
    end
  end
end
