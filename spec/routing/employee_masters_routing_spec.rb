require "rails_helper"

RSpec.describe EmployeeMastersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/employee_masters").to route_to("employee_masters#index")
    end

    it "routes to #new" do
      expect(:get => "/employee_masters/new").to route_to("employee_masters#new")
    end

    it "routes to #show" do
      expect(:get => "/employee_masters/1").to route_to("employee_masters#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/employee_masters/1/edit").to route_to("employee_masters#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/employee_masters").to route_to("employee_masters#create")
    end

    it "routes to #update" do
      expect(:put => "/employee_masters/1").to route_to("employee_masters#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/employee_masters/1").to route_to("employee_masters#destroy", :id => "1")
    end

  end
end
