class MultipleChoiceEntry < ActiveRecord::Base
  belongs_to :multiple_choice_question
  belongs_to :form_entry
end
