require 'rails_helper'

RSpec.describe "salary_break_ups/show", :type => :view do
  before(:each) do
    @salary_break_up = assign(:salary_break_up, SalaryBreakUp.create!(
      :component => "Component",
      :criteria => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Component/)
    expect(rendered).to match(/1.5/)
  end
end
