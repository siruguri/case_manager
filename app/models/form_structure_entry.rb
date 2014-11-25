class FormStructureEntry < ActiveRecord::Base
  belongs_to :form_structure
  belongs_to :question, polymorphic: true, inverse_of: :form_structure_entries

  validates :question, presence: true
end
