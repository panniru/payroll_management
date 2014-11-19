require 'rails_helper'

RSpec.describe "salary_break_ups/index", :type => :view do
  before(:each) do
    assign(:salary_break_ups, [
      SalaryBreakUp.create!(
        :component => "Component",
        :criteria => 1.5
      ),
      SalaryBreakUp.create!(
        :component => "Component",
        :criteria => 1.5
      )
    ])
  end

  it "renders a list of salary_break_ups" do
    render
    assert_select "tr>td", :text => "Component".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
