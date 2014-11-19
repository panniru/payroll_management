require "rails_helper"

RSpec.describe SalaryBreakUpsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/salary_break_ups").to route_to("salary_break_ups#index")
    end

    it "routes to #new" do
      expect(:get => "/salary_break_ups/new").to route_to("salary_break_ups#new")
    end

    it "routes to #show" do
      expect(:get => "/salary_break_ups/1").to route_to("salary_break_ups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/salary_break_ups/1/edit").to route_to("salary_break_ups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/salary_break_ups").to route_to("salary_break_ups#create")
    end

    it "routes to #update" do
      expect(:put => "/salary_break_ups/1").to route_to("salary_break_ups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/salary_break_ups/1").to route_to("salary_break_ups#destroy", :id => "1")
    end

  end
end
