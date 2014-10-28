action_data = [
               {name: 'toggle_client_flag', role_name: 'volunteer'},
               {name: 'add_note', role_name: 'volunteer'},
               {name: 'update_case_contact', role_name: 'manager'},
               {name: 'set_client_priorities', role_name: 'manager'}
]

action_data.each do |entry|
  a=ApiAction.where(name: entry[:name]).first_or_initialize
  a.role=Role.find_by_name entry[:role_name]
  a.save
end
