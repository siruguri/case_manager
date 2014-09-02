class MultipleChoiceQuestion < ActiveRecord::Base
  has_many :form_structure_entries
  has_many :form_structures, through: :form_structure_entries

  def choice_array
    if self.is_boolean
      ['Yes', 'No']
    else
      self.choices.split(',')
    end
  end
end
