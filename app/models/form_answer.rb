class FormAnswer < ActiveRecord::Base
  belongs_to :form_entry
  belongs_to :question, polymorphic: true
end
