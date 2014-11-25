class CreateFormStructureEntries < ActiveRecord::Migration
  def change
    create_table :form_structure_entries do |t|
      t.integer :question_id
      t.string :question_type
      t.integer :form_structure_id
      t.integer :sort_order
      
      t.timestamps
    end
  end
end
