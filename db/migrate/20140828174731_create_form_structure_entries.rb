class CreateFormStructureEntries < ActiveRecord::Migration
  def change
    create_table :form_structure_entries do |t|
      t.integer :boolean_question_id
      t.integer :form_structure_id
    end
  end
end
