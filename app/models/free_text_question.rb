class FreeTextQuestion < ActiveRecord::Base
  include AbstractQuestion

  has_many :form_structure_entries, foreign_key: :question_id, as: :question, inverse_of: :question
  has_many :form_structures, through: :form_structure_entries

end
