class FreeTextQuestion < ActiveRecord::Base
  include AbstractQuestion

  has_many :form_structure_entries, foreign_key: :question_id
  has_many :form_structures, through: :form_structure_entries

end
