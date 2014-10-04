YesNoFlag.find_or_create_by(key: :special_attention) do |flg|
  flg.display_value='Needs Attention'
  flg.save
end

cts = [{first_name: 'Henry', last_name: 'Poole', mr_number: 8600, case_contact: 'vol2', flags: {special_attention: true}}, 
       {first_name: 'Linda', last_name: 'Wong', mr_number: 9512, case_contact_key: 'vol1'},
      ]

cts.each do |ct|
  x=Client.find_or_initialize_by(mr_number: ct[:mr_number])
  x.first_name = ct[:first_name]
  x.last_name = ct[:last_name]

  if ct[:flags]
    keys=ct[:flags].map { |k, v| v ? k : nil }.compact 
    keys.each do |key|
      cf=ClientFlag.new
      cf.client=x
      cf.yes_no_flag=YesNoFlag.find_by_key(key)
      cf.save
    end
  end

  if (v=User.find_by_email "#{ct[:case_contact_key]}@casemanager.com")
    x.case_contact = v
  end
  x.save
end
