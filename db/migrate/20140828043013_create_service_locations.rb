class CreateServiceLocations < ActiveRecord::Migration
  def change
    create_table :service_locations do |t|
      t.string :name
      t.integer :address_entry_id
    end
  end
end
