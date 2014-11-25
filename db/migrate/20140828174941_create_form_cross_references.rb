class CreateFormCrossReferences < ActiveRecord::Migration
  def change
    create_table :form_cross_references do |t|
      t.integer :form_entry_id
      t.string :cross_reference_type
      t.integer :cross_reference_id

      t.timestamps
    end
  end
end
