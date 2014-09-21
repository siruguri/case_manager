FormStructure.find_or_create_by(id: 1) do |fs|
  fs.form_name='Enrolment'
  fs.save
end

qns = [{key: :language_choice, dv: 'Which language would you like to answer questions in?', choices: 'English,Spanish'},
       {key: :primary_caregiver, dv: 'Are you the primary caregiver?', is_boolean: true},
       {key: :study_participate, dv: 'Do you want to participate in the study?', is_boolean: true}]

qns.each do |qn_h|
  MultipleChoiceQuestion.find_or_create_by(key: qn_h[:key]) do |qn|
    qn.display_value = qn_h[:dv]
    qn.is_boolean = (qn_h[:is_boolean] == true)
    qn.choices = qn_h[:choices]
    qn.save
  end
end

# Add all of these qns to the above form structure
fs = FormStructure.find_or_create_by(id: 1)
MultipleChoiceQuestion.all.each do |mcq|
  fs.multiple_choice_questions << mcq
end
