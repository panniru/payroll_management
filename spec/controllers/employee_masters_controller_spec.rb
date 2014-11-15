require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe EmployeeMastersController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # EmployeeMaster. As you add validations to EmployeeMaster, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EmployeeMastersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all employee_masters as @employee_masters" do
      employee_master = EmployeeMaster.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:employee_masters)).to eq([employee_master])
    end
  end

  describe "GET show" do
    it "assigns the requested employee_master as @employee_master" do
      employee_master = EmployeeMaster.create! valid_attributes
      get :show, {:id => employee_master.to_param}, valid_session
      expect(assigns(:employee_master)).to eq(employee_master)
    end
  end

  describe "GET new" do
    it "assigns a new employee_master as @employee_master" do
      get :new, {}, valid_session
      expect(assigns(:employee_master)).to be_a_new(EmployeeMaster)
    end
  end

  describe "GET edit" do
    it "assigns the requested employee_master as @employee_master" do
      employee_master = EmployeeMaster.create! valid_attributes
      get :edit, {:id => employee_master.to_param}, valid_session
      expect(assigns(:employee_master)).to eq(employee_master)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new EmployeeMaster" do
        expect {
          post :create, {:employee_master => valid_attributes}, valid_session
        }.to change(EmployeeMaster, :count).by(1)
      end

      it "assigns a newly created employee_master as @employee_master" do
        post :create, {:employee_master => valid_attributes}, valid_session
        expect(assigns(:employee_master)).to be_a(EmployeeMaster)
        expect(assigns(:employee_master)).to be_persisted
      end

      it "redirects to the created employee_master" do
        post :create, {:employee_master => valid_attributes}, valid_session
        expect(response).to redirect_to(EmployeeMaster.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved employee_master as @employee_master" do
        post :create, {:employee_master => invalid_attributes}, valid_session
        expect(assigns(:employee_master)).to be_a_new(EmployeeMaster)
      end

      it "re-renders the 'new' template" do
        post :create, {:employee_master => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested employee_master" do
        employee_master = EmployeeMaster.create! valid_attributes
        put :update, {:id => employee_master.to_param, :employee_master => new_attributes}, valid_session
        employee_master.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested employee_master as @employee_master" do
        employee_master = EmployeeMaster.create! valid_attributes
        put :update, {:id => employee_master.to_param, :employee_master => valid_attributes}, valid_session
        expect(assigns(:employee_master)).to eq(employee_master)
      end

      it "redirects to the employee_master" do
        employee_master = EmployeeMaster.create! valid_attributes
        put :update, {:id => employee_master.to_param, :employee_master => valid_attributes}, valid_session
        expect(response).to redirect_to(employee_master)
      end
    end

    describe "with invalid params" do
      it "assigns the employee_master as @employee_master" do
        employee_master = EmployeeMaster.create! valid_attributes
        put :update, {:id => employee_master.to_param, :employee_master => invalid_attributes}, valid_session
        expect(assigns(:employee_master)).to eq(employee_master)
      end

      it "re-renders the 'edit' template" do
        employee_master = EmployeeMaster.create! valid_attributes
        put :update, {:id => employee_master.to_param, :employee_master => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested employee_master" do
      employee_master = EmployeeMaster.create! valid_attributes
      expect {
        delete :destroy, {:id => employee_master.to_param}, valid_session
      }.to change(EmployeeMaster, :count).by(-1)
    end

    it "redirects to the employee_masters list" do
      employee_master = EmployeeMaster.create! valid_attributes
      delete :destroy, {:id => employee_master.to_param}, valid_session
      expect(response).to redirect_to(employee_masters_url)
    end
  end

end
