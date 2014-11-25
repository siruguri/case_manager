class CreateFormStructures < ActiveRecord::Migration
  def change
    create_table :form_structures do |t|
      t.string :form_name
      t.integer :author_id
      
      t.timestamps
    end
  end
end
