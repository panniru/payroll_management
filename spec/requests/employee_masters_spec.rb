require 'rails_helper'

RSpec.describe "EmployeeMasters", :type => :request do
  describe "GET /employee_masters" do
    it "works! (now write some real specs)" do
      get employee_masters_path
      expect(response).to have_http_status(200)
    end
  end
end
