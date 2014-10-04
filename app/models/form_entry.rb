class FormEntry < ActiveRecord::Base
  attr_accessor :answer_list

  belongs_to :form_author, class_name: 'User'
  belongs_to :form_structure

  has_many :form_answers

  has_many :form_cross_references
  has_many :clients, through: :form_cross_references, source: :cross_reference, source_type: 'Client'

  accepts_nested_attributes_for :form_cross_references
  accepts_nested_attributes_for :clients
  accepts_nested_attributes_for :form_answers

  def client_cross_reference
     if self.clients[0].nil?
       return 'No client!' 
     else
       self.clients[0].display_name
     end
  end

  def answer(key)
    # cache the answers first the first time we call this
    if @answer_list.nil?
      keys=self.form_answers.map(&:question)
      ans_idxs=self.form_answers.map(&:answer_value)
      @answer_list = keys.zip(ans_idxs).map do |q, a|
        [q.key.to_sym, q.choices[a.to_i]]
      end
    end

    @answer_list.select { |x| x[0]==key}.first[1]
  end

  def form_structure_id
    # For new form's hidden field
    self.form_structure.id
  end
end
