class RemoveMultipleChoiceQuestionIdFromFormStructureEntry < ActiveRecord::Migration
  def change
    remove_column :form_structure_entries, :multiple_choice_question_id
  end
end
