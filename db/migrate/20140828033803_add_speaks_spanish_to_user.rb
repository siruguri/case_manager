class AddSpeaksSpanishToUser < ActiveRecord::Migration
  def change
    add_column :users, :speaks_spanish, :boolean
  end
end
