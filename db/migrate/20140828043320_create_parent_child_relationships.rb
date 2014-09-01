class CreateParentChildRelationships < ActiveRecord::Migration
  def change
    create_table :parent_child_relationships do |t|
      t.integer :child_id
      t.integer :parent_id
      t.integer :family_id
    end
  end
end
