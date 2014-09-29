class CreateThemeComponents < ActiveRecord::Migration
  def change
    create_table :theme_components do |t|
      t.string :theme_config
      t.integer :organization_id
    end
  end
end
