class UpdateFormCrossRefToPolymorphic < ActiveRecord::Migration
  def change
    rename_column :form_cross_references, :cross_reference_class, :cross_reference_type
  end
end
