class IncorrectSeedData < Exception
end

def load_mc_qns(mc_qns)
  mc_qns.each do |qn_h|
    qn = MultipleChoiceQuestion.find_or_initialize_by(key: qn_h[:key])
    qn.display_value = qn_h[:dv]
    qn.is_boolean = (qn_h[:is_boolean] == true)
    if qn_h[:choices]
      qn.choices = qn_h[:choices]
    elsif qn.is_boolean
      qn.choices = MultipleChoiceQuestion.boolean_choice_array
    else
      raise IncorrectSeedData, "Seed (choices) data for qn #{qn_h} is incomplete"
    end
    qn.save
  end
end

def load_freetext_qns(free_text_qns)
  free_text_qns.each do |qn_h|
    qn=FreeTextQuestion.find_or_initialize_by(key: qn_h[:key])
    qn.display_value = qn_h[:dv]
    qn.save
  end
end

def initialize_form_structure(name, order)
  s = FormStructure.find_by_form_name name
  order.each_with_index do |key, idx|
    qn = [MultipleChoiceQuestion.find_by_key(key), FreeTextQuestion.find_by_key(key)].compact.first
    s.add_question qn, idx
  end
end

fs=FormStructure.find_or_create_by(id: 1)
fs.form_name='Eligibility'
fs.author = User.find_by_email('cho_encore.mgr@casemanager.com')
fs.save
cho_eligibility_form=fs

fs=FormStructure.find_or_create_by(id: 2)
fs.form_name='Enrolment'
fs.author = User.find_by_email('cho_encore.mgr@casemanager.com')
fs.save
cho_enrolment_form=fs

fs=FormStructure.find_or_create_by(id: 3)
fs.form_name='START Survey'
fs.author = User.find_by_email('youth_alive.mgr@casemanager.com')
fs.save
ya_start_form=fs

# CHO Encore Eligibility
free_text_qns =\
[{key: :no_study_reason, dv: 'If you are not participating in the study, please describe why.'},
 {key: :no_primary_language, dv: 'If your primary language is not listed, please specify it here.'},
 {key: :no_alameda_resident, dv: 'If you\'re not a resident of Alameda County, please enter your county of residence.'},
 {key: :general_comments, dv: 'Comments'},
]; load_freetext_qns free_text_qns

mc_qns = 
[{key: :language_choice, dv: 'Which language would you like to answer questions in?', choices: %w(English Spanish Other)},
 {key: :study_participate, dv: 'Do you want to participate in the study?', is_boolean: true},
 {key: :primary_language, dv: 'What is your primary language?', choices: %w(English Spanish)},
 {key: :primary_caregiver, dv: 'Are you the primary caregiver?', is_boolean: true},
 {key: :over_18, dv: 'Are you over 18 years old?', is_boolean: true},
 {key: :already_participating, dv: 'Are you already participating in this study?', is_boolean: true},
 {key: :resident_of_alameda, dv: 'Are you a resident of Alameda County?', is_boolean: true},
 {key: :foster_care_child, dv: 'Is your child a foster care child or in clinic for protective clearance exam?', is_boolean: true},
]; load_mc_qns mc_qns

eligibility_order=\
[ :language_choice, :study_participate, :no_study_reason, :primary_language, :no_primary_language, :primary_caregiver, 
  :over_18, :already_participating, :resident_of_alameda, :no_alameda_resident, :foster_care_child, :general_comments]

initialize_form_structure 'Eligibility', eligibility_order

# YA START Survey
four_parts=%w(Never Rarely Sometimes Often)
mc_qns = 
[{key: :everyday_focus, dv: 'In the past 12 months have you had trouble focusing on everyday tasks, like working, doing chores, running errands or reading?', choices: four_parts},
 {key: :problems_sleeping, dv: 'In the past 12 months, how often did you have problems falling asleep or staying asleep?', choices: four_parts},
 {key: :disturbing_memories, dv: 'In the past 12 months, how often did you have disturbing memories, thoughts, or nightmares about a current or past stressful experience?', choices: four_parts},
 {key: :feel_numb, dv: 'In the past 12 months, how often did you feel numb, or not connected to people, activities or your surroundings?', choices: four_parts},
 {key: :on_guard, dv: 'In the past 12 months, how often did you feel constantly on guard, watchful or jumpy?', choices: four_parts},
 {key: :avoid_situation, dv: 'In the last 12 months, have you tried hard not to think about it or went out of your way to avoid situations that reminded you of it?', choices: four_parts},
 {key: :experience_in_30, dv: 'How often over the past 30 days did you experience any of these feelings? Would you say:', choices: four_parts}
]; load_mc_qns mc_qns

form_order=\
[:everyday_focus, :problems_sleeping, :disturbing_memories, :feel_numb, :on_guard, :avoid_situation, :experience_in_30]

initialize_form_structure 'START Survey', form_order

mc_qns = 
[{key: :full_intervention_day, dv: 'Full Intervention Day?', is_boolean: true},
 {key: :enrolment_consent, dv: 'Consent', is_boolean: true},
 {key: :intervention_plan_completed, dv: 'Intervention Plan completed?', is_boolean: true},
 {key: :qualtrics_completed, dv: 'Qualtrics Staff Survey Completed?', is_boolean: true},
]; load_mc_qns mc_qns

free_text_qns =\
[
{key: :vol_name, dv: 'Volunteer Name'},
{key: :date_of_visit, dv: 'Date of visit'},
]; load_freetext_qns free_text_qns

