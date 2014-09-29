class AddAuthorIdToFormStructures < ActiveRecord::Migration
  def change
    add_column :form_structures, :author_id, :integer
  end
end
