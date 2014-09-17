class FormEntry < ActiveRecord::Base
  belongs_to :form_author, class_name: 'User'
  belongs_to :form_structure
  has_many :form_cross_references
  has_many :multiple_choice_entries


  def cross_reference(xref_type: :client)
    if xref_type == :client
      client = self.form_cross_references.select { |x| x.cross_reference_class.underscore.to_sym == xref_type }
      puts ">>> #{client}"
      if client 
        return client[0].cross_reference_instance
      else
        return nil
      end
    end
  end
end
