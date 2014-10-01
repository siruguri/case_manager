module CustomProcessFormEntry

  def custom_add_client_flags(client, form_entry)
    class_cand = "CustomClientProcessors::#{@current_organization.org_key.camelcase}ClientProcessor"
    class_cand.constantize.new.send(:process, client, form_entry)
  end
end
