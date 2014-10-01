class AddOrgKeyToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :org_key, :string
  end
end
