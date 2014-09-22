class MultipleChoiceQuestion < ActiveRecord::Base
  include AbstractQuestion

  has_many :form_structure_entries
  has_many :form_structures, through: :form_structure_entries

  serialize :choices, Array

  def choices_with_index
    if self.is_boolean?
      [['Yes', 0], ['No', 1]]
    else
      self.choices.map.with_index(0) do |choice, idx|
        [choice, idx]
      end
    end
  end
end
