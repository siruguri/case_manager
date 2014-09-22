FormStructure.find_or_create_by(id: 1) do |fs|
  fs.form_name='Enrolment'
  fs.save
end

free_text_qns =\
[{key: :no_study_reason, dv: 'If you are not participating in the study, please describe why.'},
 {key: :no_primary_language, dv: 'If your primary language is not listed, please specify it here.'},
 {key: :no_alameda_resident, dv: 'If you\'re not a resident of Alameda County, please enter your county of residence.'},
 {key: :general_comments, dv: 'Comments'},
] 

mc_qns = 
[{key: :language_choice, dv: 'Which language would you like to answer questions in?', choices: %w(English Spanish)},
 {key: :study_participate, dv: 'Do you want to participate in the study?', is_boolean: true},
 {key: :primary_language, dv: 'What is your primary language?', choices: %w(English Spanish)},
 {key: :primary_caregiver, dv: 'Are you the primary caregiver?', is_boolean: true},
 {key: :over_18, dv: 'Are you over 18 years old?', is_boolean: true},
 {key: :already_participating, dv: 'Are you already participating in this study?', is_boolean: true},
 {key: :resident_of_alameda, dv: 'Are you a resident of Alameda County?', is_boolean: true},
 {key: :foster_care_child, dv: 'Is your child a foster care child or in clinic for protective clearance exam?', is_boolean: true},
]

enrolment_order=\
[ :language_choice, :study_participate, :no_study_reason, :primary_language, :no_primary_language, :primary_caregiver, 
  :over_18, :already_participating, :resident_of_alameda, :no_alameda_resident, :foster_care_child, :general_comments]

mc_qns.each do |qn_h|
  qn = MultipleChoiceQuestion.find_or_initialize_by(key: qn_h[:key])
  qn.display_value = qn_h[:dv]
  qn.is_boolean = (qn_h[:is_boolean] == true)
  qn.choices = qn_h[:choices]
  qn.save
end

free_text_qns.each do |qn_h|
  qn=FreeTextQuestion.find_or_initialize_by(key: qn_h[:key])
  qn.display_value = qn_h[:dv]
  qn.save
end

# Add all of these qns to the above form structure
s = FormStructure.find_by_form_name 'Enrolment'
enrolment_order.each_with_index do |key, idx|
  qn = [MultipleChoiceQuestion.find_by_key(key), FreeTextQuestion.find_by_key(key)].compact.first
  s.add_question qn, idx
end

