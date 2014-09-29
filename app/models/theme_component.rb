class ThemeComponent < ActiveRecord::Base
  serialize :theme_config, Hash

  belongs_to :theme_owner, inverse_of: :theme_components, class_name: 'Organization'
  
  def method_missing(sym)
    # Use method_missing to convert a method call to the theme value

    if self.theme_config[sym]
      return self.theme_config[sym]
    else
      return nil
    end
  end

  def self.current_theme
    current_user.employer.themes.where(is_active: true).first
  end

end
