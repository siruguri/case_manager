class CreateAppointmentRequest < ActiveRecord::Migration
  def change
    create_table :appointment_requests do |t|
      t.datetime :request_time
      t.integer :client_id
      t.integer :volunteer_id
      t.text :appointment_notes

      t.timestamps
    end
  end
end
