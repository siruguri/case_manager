class UpdateFormStructureEntryToPolymorphic < ActiveRecord::Migration
  def change
    rename_column :form_structure_entries, :boolean_question_id, :question_id
    add_column :form_structure_entries, :question_type, :string
  end
end
