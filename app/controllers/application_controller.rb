class ApplicationController < ActionController::Base
  include ApplicationHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action do
    # Quite a few things to do before the app starts...
    I18n.locale = set_locale
    insert_default_param_filter
    create_navbar_data
    load_current_configs # Theme and organization
  end

  rescue_from ActionController::RoutingError, ActiveRecord::RecordNotFound do |exception|
    error_message = I18n.t(:message_404)
    go_back_or_root(error_message)
  end
  rescue_from Errors::NeedsSignInException do |exception|
    error_message = I18n.t(exception.message)
    go_back_or_root(error_message)
  end
    
  rescue_from CanCan::AccessDenied do |exception|
    error_message = I18n.t(Errors.pretty_denial_message(exception.action, exception.subject))
    go_back_or_root(error_message)
  end

  private
  def set_locale
    # 1. Let's make our app use the locale
    
    params[:locale] || I18n.default_locale
  end

  def insert_default_param_filter
    # 2. This helps Rails4 strong parameter setting
    resource = controller_name.singularize.to_sym
    method = "#{resource}_strong_params"
    params[resource] &&= send(method, params[resource]) if respond_to?(method, true)
  end

  def create_navbar_data
    @navbar_entries = NavbarEntry.all.map do |entry|
      if entry.user_id == -1 || Ability.new(current_user).can?(:read, entry)
        {title: entry.title, url: entry.url }
      end
    end
    @navbar_entries.compact!
    @dropdown_forms=FormStructure.joins(:author).where('users.employer_id = ?', current_user.employer_id) if current_user
  end

  def go_back_or_root(message)
    if request.env.key? "HTTP_REFERER"
      redirect_to :back, :alert => message
    else
      redirect_to '/', :alert => message
    end
  end 

  # Use URL options to set locale. I prefer it that way.
  def self.default_url_options(options={})
    { locale: I18n.locale }
  end

  # Load the theme - hopes at least one theme is active
  def load_current_configs
    if current_user && current_user.employer
      @current_organization = current_user.employer
      @current_theme = @current_organization.theme_components.where(is_active: true).first
    else
      @current_organization=nil
      @current_theme=nil
    end
  end

end
