
themes=\
[{org_name_key: 'Encore', theme_config: {logo: 'find_logo.png'}, is_active: true},
 {org_name_key: 'ALIVE', theme_config: {logo: 'ya_logo.png'}, is_active: true}
]

themes.each do |theme|
  re=Regexp.new theme[:org_name_key]

  org = Organization.all.select { |x| re.match x.name }.first
  t = ThemeComponent.find_or_initialize_by organization_id: org.id
  t.config_logo_url=theme[:theme_config][:logo]

  t.is_active=theme[:is_active]

  t.save
end
