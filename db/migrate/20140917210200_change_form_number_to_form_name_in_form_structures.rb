class ChangeFormNumberToFormNameInFormStructures < ActiveRecord::Migration
  def change
    remove_column :form_structures, :form_number
    add_column :form_structures, :form_name, :string
  end
end
