class AddCodeToLeaveEncashment < ActiveRecord::Migration
  def change
    add_column :leave_encashments, :code, :string
  end
end
