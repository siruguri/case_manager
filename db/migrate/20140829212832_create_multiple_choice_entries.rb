class CreateMultipleChoiceEntries < ActiveRecord::Migration
  def change
    create_table :multiple_choice_entries do |t|
      t.integer :choice_index
      t.integer :multiple_choice_question_id
      t.integer :form_entry_id
    end
  end
end
