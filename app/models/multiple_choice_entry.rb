class FormAnswer < ActiveRecord::Base
  belongs_to :question, polymorphic: true

  belongs_to :form_entry
end
