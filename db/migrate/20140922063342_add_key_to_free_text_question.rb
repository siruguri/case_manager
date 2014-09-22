class AddKeyToFreeTextQuestion < ActiveRecord::Migration
  def change
    add_column :free_text_questions, :key, :string
  end
end
