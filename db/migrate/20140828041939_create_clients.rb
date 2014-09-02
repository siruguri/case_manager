class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.integer :mr_number
      t.integer :family_id

      t.timestamps
    end
  end
end
