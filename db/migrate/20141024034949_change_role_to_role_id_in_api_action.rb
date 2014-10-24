class ChangeRoleToRoleIdInApiAction < ActiveRecord::Migration
  def change
    remove_column :api_actions, :role
    add_column :api_actions, :role_id, :integer
  end
end
