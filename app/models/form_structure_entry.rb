class FormStructureEntry < ActiveRecord::Base
  belongs_to :form_structure
  belongs_to :question, polymorphic: true
end
