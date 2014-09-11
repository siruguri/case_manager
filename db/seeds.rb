# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

entries = [{title: 'Clients', url: '/clients'}, {title: 'New Form', url: '/form_entries/new?form_number=1'}]
entries.each do |ent|
  ne = NavbarEntry.find_or_initialize_by(title: ent[:title])
  ne.url= ent[:url]
  ne.save
end
