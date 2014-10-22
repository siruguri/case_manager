# Make all the users and their roles.

['volunteer', 'manager'].each do |name|
  Role.find_or_create_by(name: name)
end

User.find_or_create_by(email: 'admin@casemanager.com') do |u|
  u.password='adminpass123'
  u.admin=true
end

org_keys = ['health_clinic', 'cho_encore', 'youth_alive']
org_keys.each do |o_key|
  org_pretty_name = o_key.camelcase

  m = User.where(email: "#{o_key}.mgr@casemanager.com").first_or_initialize
  m.password='mgrpass123'
  m.role = Role.find_by_name('manager')
  m.admin=false
  m.full_name="Manager for #{org_pretty_name}"
  m.save

  (1..3).each do |vol_num|
    v = User.where(email: "#{o_key}.vol#{vol_num}@casemanager.com").first_or_initialize
    v.password='volpass123'
    v.role = Role.find_by_name('volunteer')
    v.admin=false
    v.full_name="Volunteer (#{org_pretty_name}) ##{vol_num}"
    v.contact_email='siruguri@gmail.com'
    v.manager=m
    v.save
  end

end


