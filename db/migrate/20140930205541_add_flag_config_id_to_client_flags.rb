class AddFlagConfigIdToClientFlags < ActiveRecord::Migration
  def change
    add_column :client_flags, :flag_config_id, :integer
  end
end
