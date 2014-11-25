class RemoveDisplayValueAndKeyFromFreeTextQuestion < ActiveRecord::Migration
  def change
    remove_column :free_text_questions, :display_value
    remove_column :free_text_questions, :key
  end
end
