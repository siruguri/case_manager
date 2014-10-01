class CreateFlagConfigs < ActiveRecord::Migration
  def change
    create_table :flag_configs do |t|
      t.string :display_value
      t.string :key
    end
  end
end
