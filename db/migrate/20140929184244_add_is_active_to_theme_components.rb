class AddIsActiveToThemeComponents < ActiveRecord::Migration
  def change
    add_column :theme_components, :is_active, :boolean
  end
end
