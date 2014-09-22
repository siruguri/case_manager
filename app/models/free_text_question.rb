class FreeTextQuestion < ActiveRecord::Base
  include AbstractQuestion

  has_many :form_structure_entries
  has_many :form_structures, through: :form_structure_entries

end
