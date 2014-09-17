class FormCrossReference < ActiveRecord::Base
  belongs_to :form_entry

  def cross_reference_instance
    if self.cross_reference_class
      klass = Module.const_get self.cross_reference_class
      # maybe this could be klass.respond_to? :find instead
      if klass.is_a?(Class) and klass.superclass == ActiveRecord::Base
        return klass.send(:find, self.cross_reference_id)
      end
    end

    return nil
  end
      
end
