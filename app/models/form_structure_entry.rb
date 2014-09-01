class FormStructureEntry < ActiveRecord::Base
  belongs_to :form_structure
  belongs_to :multiple_choice_question
end
