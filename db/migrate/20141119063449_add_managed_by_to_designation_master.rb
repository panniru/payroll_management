class AddManagedByToDesignationMaster < ActiveRecord::Migration
  def change
    add_column :designation_masters, :managed_by, :integer
  end
end
