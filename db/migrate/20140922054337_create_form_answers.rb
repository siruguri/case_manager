class CreateFormAnswers < ActiveRecord::Migration
  def change
    create_table :form_answers do |t|
      t.text :answer_value
      t.integer :question_id
      t.string :question_type
      t.integer :form_entry_id
    end
  end
end
