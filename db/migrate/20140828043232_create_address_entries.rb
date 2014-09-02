class CreateAddressEntries < ActiveRecord::Migration
  def change
    create_table :address_entries do |t|
      t.float :lat
      t.float :long
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.integer :zip

      t.timestamps
    end
  end
end
