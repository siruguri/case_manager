class FormStructure < ActiveRecord::Base
  has_many :form_structure_entries
  has_many :multiple_choice_questions, through: :form_structure_entries
end
