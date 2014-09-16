class CreateClientFlags < ActiveRecord::Migration
  def change
    create_table :client_flags do |t|
      t.string :flag_value
      t.integer :yes_no_flag_id
      t.integer :client_id
    end
  end
end
