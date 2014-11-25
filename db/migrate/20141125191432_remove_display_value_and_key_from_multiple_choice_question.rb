class RemoveDisplayValueAndKeyFromMultipleChoiceQuestion < ActiveRecord::Migration
  def change
    remove_column :multiple_choice_questions, :display_value
    remove_column :multiple_choice_questions, :key
  end
end
