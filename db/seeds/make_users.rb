# Make all the users and their roles.

['volunteer', 'manager'].each do |name|
  Role.find_or_create_by(name: name)
end

User.find_or_create_by(email: 'admin@casemanager.com') do |u|
  u.password='adminpass123'
  u.admin=true
end

v = User.where(email: 'vol1@casemanager.com').first_or_initialize
v.password='volpass123'
v.role = Role.find_by_name('volunteer')
v.admin=false
v.full_name='Volunteer One'
v.contact_email='siruguri@gmail.com'
v.save

m = User.where(email: 'mgr1@casemanager.com').first_or_initialize
m.password='mgrpass123'
m.role = Role.find_by_name('manager')
m.admin=false
m.full_name='Jacques K'
m.save

unless v.manager
  v.manager = m
  v.save
end
