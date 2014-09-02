class CreateFormStructures < ActiveRecord::Migration
  def change
    create_table :form_structures do |t|
      t.string :form_number

      t.timestamps
    end
  end
end
