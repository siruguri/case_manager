class Client < ActiveRecord::Base
  belongs_to :family

  has_many :caregivers, foreign_key: :child_id, class_name: 'Client'
  has_many :children, foreign_key: :parent_id, class_name: 'Client'
  has_many :form_entries
  has_many :contact_entries
  has_many :field_notes


end
