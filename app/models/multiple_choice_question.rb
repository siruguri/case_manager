class MultipleChoiceQuestion < ActiveRecord::Base
  include AbstractQuestion

  has_many :form_structure_entries, foreign_key: :question_id
  has_many :form_structures, through: :form_structure_entries

  serialize :choices, Array

  def choices_with_index
    if self.is_boolean?
      MultipleChoiceQuestion.boolean_choice_array.zip [0,1]
    else
      self.choices.map.with_index(0) do |choice, idx|
        [choice, idx]
      end
    end
  end

  def self.boolean_choice_array
    ['Yes', 'No']
  end
end
