class CreateContactEntries < ActiveRecord::Migration
  def change
    create_table :contact_entries do |t|
      t.string :type
      t.string :value

      t.timestamps
    end
  end
end
