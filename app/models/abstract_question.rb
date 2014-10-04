module AbstractQuestion
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
