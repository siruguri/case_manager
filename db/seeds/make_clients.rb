cts = [{first_name: 'Henry', last_name: 'Poole', mr_number: 8600, case_contact: 1}, 
       {first_name: 'Linda', last_name: 'Wong', mr_number: 9512, case_contact: 2},
      ]

cts.each do |ct|
  x=Client.find_or_initialize_by(mr_number: ct[:mr_number])
  x.first_name = ct[:first_name]
  x.last_name = ct[:last_name]
  if (v=User.find_by_email "vol#{ct[:case_contact]}@casemanager.com")
    x.case_contact = v
  end
  x.save
end
