class FormEntriesController < ApplicationController
  load_and_authorize_resource

  def new
    # Assumes the form structure ref is provided as :form_number
    form_structure_name = params[:name]

    if !(fs = FormStructure.find_by_form_name form_structure_name)
      raise ActionController::RoutingError, ''
    end

    @view_info = { form_structure: fs }

    mcs = MultipleChoiceQuestion.joins(:form_structure_entries).where(form_structure_entries: {form_structure_id: fs.id})

    @form_questions = mcs.map do |q_instance|
      h = {display_value: q_instance.display_value, id: q_instance.id, multiple: q_instance.allows_multiple}
      if q_instance.is_boolean
        h[:choices_array] = {'Yes'=>0, 'No'=>1}
      else
        h[:choices_array] = {}
        q_instance.choice_array.each_with_index do |item, idx|
          h[:choices_array][item] = idx
        end
      end
      h
    end

    @client = Client.new
    @client.form_tracking_ids.build
  end

  def create
    client = Client.find_by_mr_number params[:client][:mr_number]
    if client.nil?
      # This is for a client who's not in the database
      c_p = params[:client]
      client = Client.new(c_p.permit(:first_name, :last_name, :mr_number, form_tracking_ids_attributes: [:tracking_id]))
    end

    # Set a case contact for this client
    client.case_contact = current_user

    client.save

    # Correct the form tracking id, using the client's ID
    ft = client.form_tracking_ids.select { |x| x.tracking_id.match params[:client][:form_tracking_ids_attributes]["0"]["tracking_id"]}.first
    ft.tracking_id = ft.tracking_id.gsub /\d+$/, sprintf("%04d", client.id)
    ft.save
    
    fe = FormEntry.new
    fe.form_structure = FormStructure.find params[:form_structure_id]
    fe.form_author = current_user
    fe.clients << client
    fe.save

    params[:multiple_choice_entries].each do |qn_id, idx|
      m = MultipleChoiceEntry.create(multiple_choice_question_id: qn_id, choice_index: idx, form_entry_id: fe.id)
    end

    flash[:notice] = "#{t(:successful_form_entry)} for patient ID #{client.id}"
    redirect_to '/profile'
  end

  def show
    @form_entry = FormEntry.find params[:id]
    @disp_array = {}

    @disp_array[:answers] = @form_entry.multiple_choice_entries.map do |mc_ent|
      norm_qn = mc_ent.multiple_choice_question
      {dv: norm_qn.display_value, ans: norm_qn.choice_array[mc_ent.choice_index]}
    end
  end
end


