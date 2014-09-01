class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.integer :size
    end
  end
end
