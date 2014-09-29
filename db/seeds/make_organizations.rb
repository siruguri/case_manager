orgs=\
[\
 { name: 'Youth ALIVE!', description: 'Based in Oakland, Youth ALIVE! believes that urban youth have the innate capacity to stop the violence plaguing our communities. Every day, we nurture leadership and life skills of young people affected by violence because addressing the root causes of violence saves lives.', urls: ['http://www.youthalive.org/'], org_key: 'youthalive'},
 { name: 'Encore Medical Clinic, Children\'s Hospital', description: 'The Encore Medical Clinic (EMC) addresses the unique health needs of homeless children. It is a collaboration between Primary Care and the Center for the Vulnerable Child, providing outreach, comprehensive, culturally specific case management services while providing a medical home for homeless families.', urls: ['http://www.childrenshospitaloakland.org/main/departments-services/22.aspx'], org_key: 'cho_encore'}
]

orgs.each do |org|
  org_rec = Organization.find_or_initialize_by(name: org[:name])
  org_rec.description = org[:description]
  org_rec.urls = org[:urls]
  org_rec.save

  # update all users to have an employer based on their email.
  User.all.each do |u|
    re=Regexp.new(org[:org_key])
    if re.match u.email
      u.employer = org_rec
      u.save
    end
  end
end

# From make_users org_keys = ['cho_encore', 'youthalive']

