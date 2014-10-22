class AddPriorityToClients < ActiveRecord::Migration
  def change
    add_column :clients, :priority, :integer
  end
end
