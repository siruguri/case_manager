class CreateFormTrackingIds < ActiveRecord::Migration
  def change
    create_table :form_tracking_ids do |t|
      t.string :tracking_id
      t.integer :client_id

      t.timestamps
    end
  end
end
