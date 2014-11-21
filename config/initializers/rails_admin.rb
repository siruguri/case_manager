RailsAdmin.config do |config|
  config.included_models = ["FreeTextQuestion", "MultipleChoiceQuestion", "FormStructure", "FormStructureEntry"]
  
  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'FreeTextQuestion' do
    object_label_method do
      :question_snippet
    end
  end
  config.model 'MultipleChoiceQuestion' do
    object_label_method do
      :question_snippet
    end
  end
  config.model 'FormStructure' do
    object_label_method do
      :form_name
    end
  end
  config.model 'FormStructureEntry' do
    object_label_method do
      :fse_question_snippet
    end

    list do
      sort_by :sort_order
      field :form_structure
      field :question
      field :sort_order
    end
  end

  def question_snippet
    self.display_value[0..32]
  end

  def form_name
    self.form_name
  end

  def fse_question_snippet
    self.question.display_value[0..32]
  end
end
