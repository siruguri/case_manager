ThinkingSphinx::Index.define :organization, :with => :active_record do
  # fields
  indexes name, :sortable => true
  indexes description

  # attributes - let's decide what to sort and filter by later
  # has author_id, created_at, updated_at
end
