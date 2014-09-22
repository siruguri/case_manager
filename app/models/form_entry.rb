class FormEntry < ActiveRecord::Base
  belongs_to :form_author, class_name: 'User'
  belongs_to :form_structure

  has_many :form_answers

  has_many :form_cross_references
  has_many :clients, through: :form_cross_references, source: :cross_reference, source_type: 'Client'

  accepts_nested_attributes_for :clients
  accepts_nested_attributes_for :form_answers

  def client_cross_reference
     if self.clients[0].nil?
       return 'No client!' 
     else
       self.clients[0].display_name
     end
  end
end
