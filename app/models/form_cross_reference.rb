class FormCrossReference < ActiveRecord::Base
  belongs_to :cross_reference, polymorphic: true
  belongs_to :form_entry, dependent: :destroy
end
