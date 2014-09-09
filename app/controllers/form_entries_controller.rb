class FormEntriesController < ApplicationController
  load_and_authorize_resource

  def new
    # Assumes the form structure ref is provided as :form_number
    form_structure_id = params[:form_number]
    fs = FormStructure.find form_structure_id
    @view_info = { form_structure: fs }

    mcs = MultipleChoiceQuestion.joins(:form_structure_entries).
      where(form_structure_entries: {form_structure_id: form_structure_id})

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
  end

  def create
    client = Client.find_by_mr_number params[:client][:mr_number]
    if client.nil?
      # This is for a client who's not in the database
      c_p = params[:client]
      client = Client.new(c_p.permit(:first_name, :last_name, :mr_number))
      client.save
    end

    fe = FormEntry.new
    fe.form_structure = FormStructure.find params[:form_structure_id]
    fe.form_author = current_user
    fe.save

    params[:multiple_choice_entries].each do |qn_id, idx|
      m = MultipleChoiceEntry.create(multiple_choice_question_id: qn_id, choice_index: idx, form_entry_id: fe.id)
    end

    xref = FormCrossReference.new(cross_reference_class: 'Client', cross_reference_id: client.id)
    xref.save

    fe.form_cross_references << xref

    flash[:notice] = "#{t(:successful_form_entry)} for patient ID #{client.id}"
    redirect_to '/profile'
  end

  def show
    @form_entry = FormEntry.find params[:id]
    @disp_array = {}

    ct_ref = @form_entry.form_cross_references.select { |x| x.cross_reference_class == 'Client' }.first
    ct = Client.find ct_ref.cross_reference_id

    @disp_array[:client]=ct

    @disp_array[:answers] = @form_entry.multiple_choice_entries.map do |mc_ent|
      norm_qn = mc_ent.multiple_choice_question
      {dv: norm_qn.display_value, ans: norm_qn.choice_array[mc_ent.choice_index]}
    end
  end
end


