class AddCaseContactIdToClient < ActiveRecord::Migration
  def change
    add_column :clients, :case_contact_id, :integer
  end
end
