class AddMultipleChoiceQuestionIdToFormStructureEntry < ActiveRecord::Migration
  def change
    add_column :form_structure_entries, :multiple_choice_question_id, :integer
  end
end
