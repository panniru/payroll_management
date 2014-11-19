require 'rails_helper'

RSpec.describe "salary_break_ups/edit", :type => :view do
  before(:each) do
    @salary_break_up = assign(:salary_break_up, SalaryBreakUp.create!(
      :component => "MyString",
      :criteria => 1.5
    ))
  end

  it "renders the edit salary_break_up form" do
    render

    assert_select "form[action=?][method=?]", salary_break_up_path(@salary_break_up), "post" do

      assert_select "input#salary_break_up_component[name=?]", "salary_break_up[component]"

      assert_select "input#salary_break_up_criteria[name=?]", "salary_break_up[criteria]"
    end
  end
end
