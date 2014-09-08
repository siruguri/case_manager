class AddFormAuthorIdToFormEntry < ActiveRecord::Migration
  def change
    add_column :form_entries, :form_author_id, :integer
  end
end
