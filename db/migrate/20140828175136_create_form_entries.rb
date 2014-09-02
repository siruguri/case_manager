class CreateFormEntries < ActiveRecord::Migration
  def change
    create_table :form_entries do |t|
      t.integer :form_structure_id

      t.timestamps
    end
  end
end
