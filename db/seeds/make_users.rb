# Make all the users and their roles.

['volunteer', 'manager'].each do |name|
  Role.find_or_create_by(name: name)
end

User.find_or_create_by(email: 'admin@casemanager.com') do |u|
  u.password='adminpass123'
  u.admin=true
end

User.find_or_create_by(email: 'vol1@casemanager.com') do |u|
  u.password='volpass123'
  u.role = Role.find_by_name('volunteer')
  u.admin=false
end

