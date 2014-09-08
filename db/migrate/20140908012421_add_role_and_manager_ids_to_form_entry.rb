class AddRoleAndManagerIdsToFormEntry < ActiveRecord::Migration
  def change
    add_column :users, :role_id, :integer
    add_column :users, :manager_id, :integer
  end
end
