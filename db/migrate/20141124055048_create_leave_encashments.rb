class CreateLeaveEncashments < ActiveRecord::Migration
  def change
    create_table :leave_encashments do |t|
      t.string :employee_master_id
      t.string :integer
      t.string :year
      t.string :string
      t.string :no_of_leaves_to_be_encashed
      t.string :integer

      t.timestamps
    end
  end
end
