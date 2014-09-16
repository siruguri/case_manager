class CreateYesNoFlags < ActiveRecord::Migration
  def change
    create_table :yes_no_flags do |t|
      t.string :display_value
      t.string :key

      t.timestamps
    end
  end
end
