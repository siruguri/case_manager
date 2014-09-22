class AddSortOrderToFormStructureEntry < ActiveRecord::Migration
  def change
    add_column :form_structure_entries, :sort_order, :integer
  end
end
