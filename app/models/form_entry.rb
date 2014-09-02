class FormEntry < ActiveRecord::Base

  belongs_to :form_structure
  has_many :form_cross_references
  has_many :multiple_choice_entries

end
