class AbstractQuestion < ActiveRecord::Base
  has_many :form_structure_entries, as: :question, foreign_key: :question_id, inverse_of: :question
  has_many :form_structures, through: :form_structure_entries
  validates :display_value, :key, presence: true

  def answer(val)
    if self.class == FreeTextQuestion
      return val
    elsif self.class == MultipleChoiceQuestion
      if self.is_boolean?
        choice_array=MultipleChoiceQuestion.boolean_choice_array
      else 
        choice_array=self.choices
      end

      return choice_array[val.to_i]
    end
  end
end
