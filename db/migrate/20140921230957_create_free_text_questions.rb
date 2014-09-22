class CreateFreeTextQuestions < ActiveRecord::Migration
  def change
    create_table :free_text_questions do |t|
      t.string :display_value
    end
  end
end
