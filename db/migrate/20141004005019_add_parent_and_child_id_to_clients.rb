class AddParentAndChildIdToClients < ActiveRecord::Migration
  def change
    add_column :clients, :child_id, :integer
    add_column :clients, :parent_id, :integer
  end
end
