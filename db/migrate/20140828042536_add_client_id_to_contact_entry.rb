class AddClientIdToContactEntry < ActiveRecord::Migration
  def change
    add_column :contact_entries, :client_id, :integer
  end
end
