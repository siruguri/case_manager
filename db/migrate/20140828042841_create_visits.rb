class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.datetime :visit_date
      t.integer :client_id
      t.integer :service_location_id

      t.timestamps
    end
  end
end
