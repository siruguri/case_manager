class AddContactEmailAndFullNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :contact_email, :string
    add_column :users, :full_name, :string
  end
end
