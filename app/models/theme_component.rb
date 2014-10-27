class ThemeComponent < ActiveRecord::Base
  serialize :theme_config, Hash

  belongs_to :theme_owner, inverse_of: :theme_components, class_name: 'Organization'
  
  def method_missing(sym, *args)
    # Use method_missing to convert a method call to the theme value

    # Pass control to super except for specific methods
    method_name = "#{sym}"
    if !(/^config_/.match method_name)
      return super
    end

    method_name = method_name.gsub(/^config_/, '')
    
    if /\=$/.match method_name
      is_assign=true
    else
      is_assign=false
    end

    sym = method_name.gsub(/\=?$/, '').to_sym

    if is_assign
      self.theme_config ||= {}
      self.theme_config[sym]=args[0]
    end

    self.theme_config.nil? ? nil : self.theme_config[sym]

  end

  def self.current_theme
    current_user.employer.themes.where(is_active: true).first
  end

end
