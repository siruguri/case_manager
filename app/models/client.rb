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
    return (false or (client_flags.select { |x| x.yes_no_flag && x.yes_no_flag.key.to_sym==flag_name and x.is_true? }).count > 0)
  end
  
  def add_flag(flag_key, flag_value=nil)
    # Let's instantly create a flag that's added to the client.
    flg = FlagConfig.find_or_initialize_by(key: flag_key) do |f|
      f.display_value = "#{flag_key}"
      f.save
    end

    flgs=self.client_flags.where(flag_config: flg)
    
    # Create a new flag for this client if there isn't one already
    if flgs.empty? or (flag_value && flgs.where(flag_value: flag_value).empty?)
      cf=self.client_flags.build
      cf.flag_value=flag_value
      cf.flag_config=flg
      cf.save
    end
  end
      
end
