orgs=\
[\
 { name: 'All Saints Episcopal Church', description: 'Food Pantry at the Neighborhood Center', urls: ['http://www.saintsalive.net/']},
 { name: 'Alameda County Family Justice Center', description: 'This center provides crisis intervention, legal services, arranges for medical and mental health services and other services necessary for victims and their families.', urls: ['http://www.www.acfjc.org/']}
]


orgs.each do |org|
  org_rec = Organization.find_or_initialize_by(name: org[:name])
  org_rec.description = org[:description]
  org_rec.urls = org[:urls]
  org_rec.save
end

