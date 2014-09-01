class CreateFieldNotes < ActiveRecord::Migration
  def change
    create_table :field_notes do |t|
      t.text :entry
      t.integer :author_id
      t.integer :client_id
    end
  end
end
