class FormStructure < ActiveRecord::Base
  has_many :form_structure_entries
  belongs_to :author, class_name: 'User'

  has_many :multiple_choice_questions, through: :form_structure_entries, source: :question, source_type: 'MultipleChoiceQuestion'
  has_many :free_text_questions, through: :form_structure_entries, source: :question, source_type: 'FreeTextQuestion'

  accepts_nested_attributes_for :form_structure_entries

  def add_question(qn, sort_order)
    if qn.class==MultipleChoiceQuestion
      if !self.multiple_choice_questions.include?(qn)
        self.multiple_choice_questions << qn
      end
    elsif qn.class==FreeTextQuestion
      if !self.free_text_questions.include?(qn)
        self.free_text_questions << qn
      end
    end
    entered = self.form_structure_entries.where(question_id: qn.id, question_type: qn.class.to_s).first
    entered.sort_order= sort_order
    entered.save
  end

  def all_questions
    self.form_structure_entries.map do |fse|
      fse.question
    end
  end

  def sorted_questions
    self.form_structure_entries.order(:sort_order).map do |fse|
      fse.question
    end
  end
end
