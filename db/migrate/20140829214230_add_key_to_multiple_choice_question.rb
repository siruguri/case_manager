class AddKeyToMultipleChoiceQuestion < ActiveRecord::Migration
  def change
    add_column :multiple_choice_questions, :key, :string
  end
end
