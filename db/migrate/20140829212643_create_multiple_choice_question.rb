class CreateMultipleChoiceQuestion < ActiveRecord::Migration
  def change
    create_table :multiple_choice_questions do |t|
      t.string :display_value
      t.text :choices
      t.boolean :is_boolean
      t.boolean :allows_multiple
    end
  end
end
