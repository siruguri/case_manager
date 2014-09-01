class FormEntriesController < ApplicationController
  def new
    # Assumes the form structure ref is provided as :form_number
    form_structure_id = params[:form_number]
    fs = FormStructure.find form_structure_id
    @view_info = { form_structure: fs }

    mcs = MultipleChoiceQuestion.joins(:form_structure_entries).
      where(form_structure_entries: {form_structure_id: form_structure_id})

    @form_questions = mcs.map do |q_instance|
      h = {display_value: q_instance.display_value, key: q_instance.key, multiple: q_instance.allows_multiple}
      if q_instance.is_boolean
        h[:choices_array] = ['Yes', 'No']
      else
        h[:choices_array] = q_instance.choices.split(',')
      end
      h
    end

    @client = Client.new
  end

  def create

    if params[:patient_id]
      client = Client.find params[:patient_id]
    else
      # This is for a client who's not in the database
      c_p = params[:client]
      client = Client.new(c_p.permit(:first_name, :last_name, :mr_number))
    end
    client.save unless client.id

    fe = FormEntry.new
    fe.form_structure = FormStructure.find params[:form_structure_id]
    fe.save

    xref = FormCrossReference.new(cross_reference_class: 'Client', cross_reference_id: client.id)
    xref.save

    fe.form_cross_references << xref

    flash[:notice] = "#{t(:successful_form_entry)} for patient ID #{client.id}"
    redirect_to :root
  end

end


