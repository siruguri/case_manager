cts = [{first_name: 'Henry', last_name: 'Poole', mr_number: 8600}]

cts.each do |ct|
  Client.find_or_create_by(mr_number: ct[:mr_number]) do |x|
    x.first_name = ct[:first_name]
    x.last_name = ct[:last_name]
    x.save
  end
end
