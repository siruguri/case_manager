class FormEntriesController < ApplicationController
  include CustomProcessFormEntry
  load_and_authorize_resource

  def new
    # Assumes the form structure ref is provided as :form_number
    form_structure_name = params[:name]

    if !(@form_structure = FormStructure.find_by_form_name form_structure_name)
      raise ActionController::RoutingError, ''
    end

    @form_entry=FormEntry.new 
    @form_entry.form_structure = @form_structure
    @form_structure.sorted_questions.each do |qn|
      @form_entry.form_answers.build 
      @form_entry.form_answers.last.question = qn
    end

    @form_entry.form_cross_references.build
    @form_entry.clients.build
    client = @form_entry.clients.last
    client.form_tracking_ids.build
  end

  def create
    form_entry_p = params.require(:form_entry)

    if form_entry_p[:form_cross_references_attributes]["0"][:cross_reference_type]=='Client'
      form_entry_p.delete :clients_attributes
    else
      form_entry_p.delete :form_cross_references_attributes
    end

    @form_entry=FormEntry.new(form_entry_p)
    if @form_entry.save
      # Set a case contact for this client
      @form_entry.clients.each do |ct|
        ct.case_contact = current_user
        ct.save

        # If this is a new client, set the form tracking ID appropriately.
        if form_entry_p[:clients_attributes]
          recd_ft_id = form_entry_p[:clients_attributes]["0"][:form_tracking_ids_attributes]["0"]["tracking_id"]
          # Correct the form tracking id, using the client's ID
          ft = ct.form_tracking_ids.\
          select { |x| x.tracking_id.match recd_ft_id}.first
          ft.tracking_id = ft.tracking_id.gsub /\d+$/, sprintf("%04d", ct.id)
          ft.save
        end
      end

      @form_entry.form_author = current_user
      @form_entry.save

      @form_entry.clients.each do |ct|
        custom_add_client_flags ct, @form_entry
      end

      flash[:notice] = "#{t(:successful_form_entry)} for patient ID #{@form_entry.clients[0].id}"
      redirect_to '/profile'
    else
      flash[:alert] = 'Something went wrong in saving the form entry.'
      render :new
    end
  end

  def show
    @form_entry = FormEntry.find params[:id]
  end

  private
  def form_entry_strong_params(resource_p)
    resource_p.permit(:form_structure_id, 
                      clients_attributes: [:id, :first_name, :last_name, :mr_number, form_tracking_ids_attributes: [:tracking_id]], 
                      form_answers_attributes: [:answer_value, :question_id, :question_type],
                      form_cross_references_attributes: [:form_entry_id, :cross_reference_id, :cross_reference_type],
                      )
  end
end


