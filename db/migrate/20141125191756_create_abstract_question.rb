class CreateAbstractQuestion < ActiveRecord::Migration
  def change
    create_table :abstract_questions do |t|
      t.string :display_value
      t.string :key
      t.string :type

      # For MultipleChoiceQuestion
      t.text :choices
      t.boolean :is_boolean
      t.boolean :allows_multiple
    end
  end
end
