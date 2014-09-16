cts = [{first_name: 'Henry', last_name: 'Poole', mr_number: 8600}]

v = User.find_by_email 'vol1@casemanager.com'

cts.each do |ct|
  Client.find_or_create_by(mr_number: ct[:mr_number]) do |x|
    x.first_name = ct[:first_name]
    x.last_name = ct[:last_name]
    if v
      x.case_contact = v
    end
    x.save
  end
end
