class CreateApiActions < ActiveRecord::Migration
  def change
    create_table :api_actions do |t|
      t.string :name
      t.string :role
    end
  end
end
