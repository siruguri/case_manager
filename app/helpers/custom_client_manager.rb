module CustomClientManager

  def custom_add_client_flags(client, form_entry)
    class_cand = "CustomClientProcessors::#{@current_organization.org_key.camelcase}ClientProcessor"
    begin
      klass=class_cand.constantize
      klass.new.send(:process, client, form_entry)
    rescue NameError => e
      return nil
    end
      
  end

  def custom_form_message(form_entry)
    class_cand = "CustomClientProcessors::#{@current_organization.org_key.camelcase}FormMessageProcessor"
    begin
      klass=class_cand.constantize
      return klass.new.send(:process, form_entry)
    rescue NameError => e
      return nil
    end
  end
    
end
