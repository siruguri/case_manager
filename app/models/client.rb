class Client < ActiveRecord::Base
  belongs_to :family

  has_many :caregivers, foreign_key: :child_id, class_name: 'Client'
  has_many :children, foreign_key: :parent_id, class_name: 'Client'

  has_many :form_cross_references, as: :cross_reference, dependent: :destroy
  has_many :form_entries, through: :form_cross_references, dependent: :destroy

  has_many :contact_entries
  has_many :field_notes
  has_many :form_tracking_ids
  accepts_nested_attributes_for :form_tracking_ids
  
  belongs_to :case_contact, class_name: 'User'

  has_many :client_flags
  has_many :yes_no_flags, through: :client_flags

  def display_name
    if self.first_name
      "#{self.first_name} #{self.last_name}"
    else
      self.last_name
    end
  end

  def has_flag?(flag_name)
    return (false or (client_flags.select { |x| x.yes_no_flag.key.to_sym==flag_name and x.is_true? }).count > 0)
  end
end
